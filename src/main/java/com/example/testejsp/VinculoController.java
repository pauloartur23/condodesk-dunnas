package com.example.testejsp;

import com.example.testejsp.model.Usuario;
import com.example.testejsp.model.Unidade;
import com.example.testejsp.repository.UsuarioRepository;
import com.example.testejsp.repository.UnidadeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/vinculos")
public class VinculoController {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private UnidadeRepository unidadeRepository;

    @GetMapping("/novo")
    public String exibirFormularioVinculo(Model model) {
        model.addAttribute("moradores", usuarioRepository.findAll());
        model.addAttribute("unidades", unidadeRepository.findAll());
        return "vincular-unidade";
    }

    @PostMapping("/salvar")
    public String efetivarVinculo(@RequestParam Long usuarioId, @RequestParam Long unidadeId) {
        Usuario usuario = usuarioRepository.findById(usuarioId)
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));
        Unidade unidade = unidadeRepository.findById(unidadeId)
                .orElseThrow(() -> new RuntimeException("Unidade não encontrada"));

        usuario.getUnidades().add(unidade);
        usuarioRepository.save(usuario);

        return "redirect:/admin/vinculos/novo?sucesso=true";
    }
}
