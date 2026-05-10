package com.example.testejsp;

import com.example.testejsp.model.Chamado;
import com.example.testejsp.model.Unidade;
import com.example.testejsp.model.Usuario;
import com.example.testejsp.repository.ChamadoRepository;
import com.example.testejsp.repository.UnidadeRepository;
import com.example.testejsp.repository.UsuarioRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class MoradorController {

    @Autowired private ChamadoRepository chamadoRepository;
    @Autowired private UsuarioRepository usuarioRepository;

    @GetMapping("/morador/painel")
    public String painelMorador(Model model, HttpSession session) {
        Usuario logado = (Usuario) session.getAttribute("usuarioLogado");
        if (logado == null) return "redirect:/login";

        // Recarrega o usuário do banco para ter as unidades carregadas
        Usuario usuarioAtualizado = usuarioRepository.findById(logado.getId()).orElse(logado);

        List<Unidade> unidades = usuarioAtualizado.getUnidades();
        if (unidades == null) unidades = new ArrayList<>();

        List<Unidade> unidadesFinais = unidades;
        List<Chamado> meusChamados = chamadoRepository.findAll().stream()
                .filter(c -> c.getUnidade() != null && unidadesFinais.stream()
                        .anyMatch(u -> u.getId().equals(c.getUnidade().getId())))
                .collect(Collectors.toList());

        model.addAttribute("usuarioLogado", usuarioAtualizado);
        model.addAttribute("unidades", unidades);
        model.addAttribute("meusChamados", meusChamados);
        return "painel-morador";
    }

    @GetMapping("/colaborador/painel")
    public String painelColaborador(Model model, HttpSession session) {
        Usuario logado = (Usuario) session.getAttribute("usuarioLogado");
        if (logado == null) return "redirect:/login";
        model.addAttribute("usuarioLogado", logado);
        model.addAttribute("chamados", chamadoRepository.findAll());
        return "painel-colaborador";
    }
}