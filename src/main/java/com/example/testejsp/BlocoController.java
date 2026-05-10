package com.example.testejsp;

import com.example.testejsp.model.Bloco;
import com.example.testejsp.service.BlocoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/blocos")
public class BlocoController {

    @Autowired
    private BlocoService blocoService;

    // Rota que carrega a sua interface futurista
    @GetMapping("/novo")
    public String exibirFormulario() {
        return "cadastro-bloco";
    }

    // Rota que recebe os dados do formulário (Onde estava dando o erro 404)
    @PostMapping("/salvar")
    public String salvar(Bloco bloco) {
        // Chama o service para salvar o bloco e gerar as unidades automaticamente
        blocoService.salvarEGerarUnidades(bloco);

        // Redireciona de volta para o formulário com um parâmetro de sucesso para a animação
        return "redirect:/admin/blocos/novo?sucesso=true";
    }
}