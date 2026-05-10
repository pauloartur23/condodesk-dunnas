package com.example.testejsp;

import com.example.testejsp.model.Usuario;
import com.example.testejsp.model.TipoUsuario;
import com.example.testejsp.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @GetMapping("/novo")
    public String exibirFormulario(Model model) {
        model.addAttribute("tipos", TipoUsuario.values());
        return "cadastro-usuario";
    }

    @PostMapping("/salvar")
    public String salvar(Usuario usuario) {
        usuarioRepository.save(usuario);
        return "redirect:/admin/usuarios/novo?sucesso=true";
    }
}