package com.example.testejsp;

import com.example.testejsp.model.Usuario;
import com.example.testejsp.model.TipoUsuario;
import com.example.testejsp.repository.AuditoriaRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AuditoriaController {

    @Autowired
    private AuditoriaRepository auditoriaRepository;

    @GetMapping("/admin/auditoria")
    public String listar(Model model, HttpSession session) {
        Usuario logado = (Usuario) session.getAttribute("usuarioLogado");
        if (logado == null) return "redirect:/login";
        if (!TipoUsuario.ADMIN.equals(logado.getTipo())) return "redirect:/dashboard";

        model.addAttribute("registros", auditoriaRepository.findAllByOrderByDataHoraDesc());
        model.addAttribute("usuarioLogado", logado);
        return "admin-auditoria";
    }
}