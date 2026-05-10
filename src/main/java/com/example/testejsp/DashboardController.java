package com.example.testejsp;

import com.example.testejsp.model.TipoUsuario;
import com.example.testejsp.model.Unidade;
import com.example.testejsp.model.Usuario;
import com.example.testejsp.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class DashboardController {

    @Autowired private ChamadoRepository chamadoRepository;
    @Autowired private UsuarioRepository usuarioRepository;
    @Autowired private UnidadeRepository unidadeRepository;
    @Autowired private BlocoRepository blocoRepository;

    @GetMapping("/dashboard")
    public String abrirAdmin(Model model, HttpSession session) {
        Usuario logado = (Usuario) session.getAttribute("usuarioLogado");
        if (logado == null) return "redirect:/login";

        model.addAttribute("totalChamados", chamadoRepository.count());
        model.addAttribute("totalUsuarios", usuarioRepository.count());
        model.addAttribute("totalUnidades", unidadeRepository.count());
        model.addAttribute("totalBlocos", blocoRepository.count());
        model.addAttribute("ultimosChamados", chamadoRepository.findAll());
        model.addAttribute("usuarioLogado", logado);
        return "dashboard";
    }

    @GetMapping("/admin/chamados/novo")
    public String novoAdminChamado(Model model, HttpSession session) {
        Usuario logado = (Usuario) session.getAttribute("usuarioLogado");
        if (logado == null) return "redirect:/login";
        List<Unidade> unidades = unidadeRepository.findAll();
        model.addAttribute("unidades", unidades);
        return "abrir-chamado";
    }

    @GetMapping("/admin/chamados/lista")
    public String listaAdminChamados() {
        return "redirect:/chamados";
    }

    @GetMapping("/painel-colaborador")
    public String abrirColab(HttpSession session) {
        Usuario logado = (Usuario) session.getAttribute("usuarioLogado");
        if (logado == null) return "redirect:/login";
        return "redirect:/colaborador/painel";
    }

    @GetMapping("/painel-morador")
    public String abrirMorador() {
        return "redirect:/morador/painel";
    }
}