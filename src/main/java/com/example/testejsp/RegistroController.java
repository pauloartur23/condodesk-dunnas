package com.example.testejsp;

import com.example.testejsp.model.Usuario;
import com.example.testejsp.model.TipoUsuario;
import com.example.testejsp.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RegistroController {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @GetMapping("/registrar")
    public String exibirFormulario() {
        return "registrar";
    }

    @PostMapping("/registrar")
    public String registrar(Usuario usuario, @RequestParam("tipo") String tipoString) {
        usuario.setTipo(TipoUsuario.valueOf(tipoString.toUpperCase()));
        usuarioRepository.save(usuario);
        return "redirect:/login";
    }
}