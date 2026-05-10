package com.example.testejsp;

import com.example.testejsp.model.*;
import com.example.testejsp.repository.*;
import com.example.testejsp.service.AuditoriaService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/chamados")
public class ChamadoController {

    @Autowired private ChamadoRepository chamadoRepository;
    @Autowired private UnidadeRepository unidadeRepository;
    @Autowired private ComentarioRepository comentarioRepository;
    @Autowired private StatusChamadoRepository statusChamadoRepository;
    @Autowired private TipoChamadoRepository tipoChamadoRepository;
    @Autowired private AuditoriaService auditoriaService;

    @GetMapping
    public String listar(@RequestParam(required = false) String status,
                         Model model, HttpSession session) {
        Usuario logado = (Usuario) session.getAttribute("usuarioLogado");
        if (logado == null) return "redirect:/login";

        List<Chamado> chamados;
        if (TipoUsuario.ADMIN.equals(logado.getTipo()) || TipoUsuario.COLABORADOR.equals(logado.getTipo())) {
            chamados = chamadoRepository.findAll();
        } else {
            List<Long> ids = logado.getUnidades().stream().map(Unidade::getId).collect(Collectors.toList());
            chamados = chamadoRepository.findAll().stream()
                    .filter(c -> c.getUnidade() != null && ids.contains(c.getUnidade().getId()))
                    .collect(Collectors.toList());
        }

        if (status != null && !status.isEmpty()) {
            chamados = chamados.stream()
                    .filter(c -> status.equals(c.getStatus()))
                    .collect(Collectors.toList());
        }

        model.addAttribute("chamados", chamados);
        model.addAttribute("usuarioLogado", logado);
        model.addAttribute("statusList", statusChamadoRepository.findAll());
        return "lista-chamados";
    }

    @GetMapping("/novo")
    public String exibirFormulario(Model model, HttpSession session) {
        Usuario logado = (Usuario) session.getAttribute("usuarioLogado");
        if (logado == null) return "redirect:/login";

        List<Unidade> unidades;
        if (TipoUsuario.ADMIN.equals(logado.getTipo()) || TipoUsuario.COLABORADOR.equals(logado.getTipo())) {
            unidades = unidadeRepository.findAll();
        } else {
            unidades = logado.getUnidades();
        }

        // CORRIGIDO: tipos de chamado vêm do banco, não hardcoded
        model.addAttribute("unidades", unidades);
        model.addAttribute("tiposChamado", tipoChamadoRepository.findAll());
        return "abrir-chamado";
    }

    @PostMapping("/salvar")
    public String salvar(@RequestParam String titulo,
                         @RequestParam String descricao,
                         @RequestParam Long unidadeId,
                         @RequestParam(required = false) Long tipoChamadoId,
                         HttpSession session) {
        Usuario logado = (Usuario) session.getAttribute("usuarioLogado");
        if (logado == null) return "redirect:/login";

        // CORRIGIDO: morador só pode abrir chamado para suas próprias unidades
        if (TipoUsuario.MORADOR.equals(logado.getTipo())) {
            boolean temAcesso = logado.getUnidades().stream()
                    .anyMatch(u -> u.getId().equals(unidadeId));
            if (!temAcesso) return "redirect:/chamados/novo?erro=sem_permissao";
        }

        Unidade unidade = unidadeRepository.findById(unidadeId).orElseThrow();

        // CORRIGIDO: status padrão vem do banco (primeiro cadastrado = ABERTO)
        StatusChamado statusPadrao = statusChamadoRepository.findAll()
                .stream().findFirst().orElse(null);
        String statusNome = statusPadrao != null ? statusPadrao.getNome() : "ABERTO";

        // CORRIGIDO: tipo de chamado vem do banco via id
        String tipoChamadoNome = null;
        if (tipoChamadoId != null) {
            tipoChamadoNome = tipoChamadoRepository.findById(tipoChamadoId)
                    .map(TipoChamado::getTitulo).orElse(null);
        }

        Chamado chamado = new Chamado();
        chamado.setTitulo(titulo);
        chamado.setDescricao(descricao);
        chamado.setUnidade(unidade);
        chamado.setStatus(statusNome);
        chamado.setTipoChamado(tipoChamadoNome);
        chamado.setDataAbertura(LocalDateTime.now());
        chamadoRepository.save(chamado);

        auditoriaService.registrar("ABERTURA", "Chamado",
                "Chamado '" + titulo + "' aberto para unidade " + unidade.getNumero(), logado);

        return TipoUsuario.MORADOR.equals(logado.getTipo()) ? "redirect:/morador/painel" : "redirect:/chamados";
    }

    @GetMapping("/{id}")
    public String detalhes(@PathVariable Long id, Model model, HttpSession session) {
        Usuario logado = (Usuario) session.getAttribute("usuarioLogado");
        if (logado == null) return "redirect:/login";

        Chamado chamado = chamadoRepository.findById(id).orElseThrow();
        List<Comentario> comentarios = comentarioRepository.findByChamadoIdOrderByDataComentarioAsc(id);

        // CORRIGIDO: calcula podeComentarFlag e envia ao model
        boolean ehGestor = TipoUsuario.ADMIN.equals(logado.getTipo())
                || TipoUsuario.COLABORADOR.equals(logado.getTipo());
        boolean ehDono = chamado.getUnidade() != null
                && chamado.getUnidade().getUsuarios() != null
                && chamado.getUnidade().getUsuarios().stream()
                        .anyMatch(u -> u.getId().equals(logado.getId()));
        boolean podeComentarFlag = ehGestor || ehDono;

        model.addAttribute("chamado", chamado);
        model.addAttribute("comentarios", comentarios);
        model.addAttribute("usuarioLogado", logado);
        model.addAttribute("statusList", statusChamadoRepository.findAll());
        model.addAttribute("podeComentarFlag", podeComentarFlag);
        return "detalhes-chamado";
    }

    @PostMapping("/{id}/comentar")
    public String comentar(@PathVariable Long id, @RequestParam String texto, HttpSession session) {
        Usuario logado = (Usuario) session.getAttribute("usuarioLogado");
        if (logado == null) return "redirect:/login";

        Chamado chamado = chamadoRepository.findById(id).orElseThrow();
        boolean ehGestor = TipoUsuario.ADMIN.equals(logado.getTipo())
                || TipoUsuario.COLABORADOR.equals(logado.getTipo());
        // CORRIGIDO: morador só comenta se a unidade do chamado é vinculada a ele
        boolean ehDono = chamado.getUnidade() != null
                && chamado.getUnidade().getUsuarios() != null
                && chamado.getUnidade().getUsuarios().stream()
                        .anyMatch(u -> u.getId().equals(logado.getId()));

        if (ehGestor || ehDono) {
            Comentario c = new Comentario();
            c.setTexto(texto);
            c.setChamado(chamado);
            c.setUsuario(logado);
            c.setDataComentario(LocalDateTime.now());
            comentarioRepository.save(c);

            auditoriaService.registrar("COMENTARIO", "Chamado #" + id,
                    "Comentário adicionado por " + logado.getNome(), logado);
        }
        return "redirect:/chamados/" + id;
    }

    @PostMapping("/{id}/status")
    public String atualizarStatus(@PathVariable Long id, @RequestParam String novoStatus, HttpSession session) {
        Usuario logado = (Usuario) session.getAttribute("usuarioLogado");
        if (logado == null) return "redirect:/login";

        // CORRIGIDO: apenas ADMIN e COLABORADOR podem alterar status
        if (TipoUsuario.ADMIN.equals(logado.getTipo()) || TipoUsuario.COLABORADOR.equals(logado.getTipo())) {
            Chamado chamado = chamadoRepository.findById(id).orElseThrow();
            String statusAnterior = chamado.getStatus();
            chamado.setStatus(novoStatus);

            // CORRIGIDO: dataFinalizacao setada quando status contém "CONCLU", limpa se não
            if (novoStatus != null && novoStatus.toUpperCase().contains("CONCLU")) {
                chamado.setDataFinalizacao(LocalDateTime.now());
            } else {
                chamado.setDataFinalizacao(null);
            }
            chamadoRepository.save(chamado);

            auditoriaService.registrar("MUDANCA_STATUS", "Chamado #" + id,
                    "Status alterado de '" + statusAnterior + "' para '" + novoStatus + "'", logado);
        }
        return "redirect:/chamados/" + id;
    }
}