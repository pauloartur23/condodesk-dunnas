package com.example.testejsp;

import com.example.testejsp.model.TipoUsuario;
import com.example.testejsp.model.Usuario;
import com.example.testejsp.repository.UsuarioRepository;
import com.example.testejsp.service.AuditoriaService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    @Autowired private UsuarioRepository usuarioRepository;
    @Autowired private AuditoriaService auditoriaService;

    @GetMapping("/")
    public String index() { return "redirect:/login"; }

    @GetMapping("/login")
    public String exibirLogin() { return "login"; }

    @PostMapping({"/login", "/logar"})
    public String autenticar(@RequestParam String email, @RequestParam String senha, HttpSession session) {
        Usuario usuario = usuarioRepository.findByEmailAndSenha(email, senha);
        if (usuario != null) {
            session.setAttribute("usuarioLogado", usuario);
            auditoriaService.registrar("LOGIN", "Usuario", "Login realizado por " + usuario.getEmail(), usuario);

            if (TipoUsuario.ADMIN.equals(usuario.getTipo())) return "redirect:/dashboard";
            if (TipoUsuario.COLABORADOR.equals(usuario.getTipo())) return "redirect:/colaborador/painel";
            return "redirect:/morador/painel";
        }
        return "redirect:/login?erro=1";
    }

    @GetMapping("/logout")
    public String sair(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}