package com.example.testejsp;

import com.example.testejsp.model.TipoChamado;
import com.example.testejsp.model.StatusChamado;
import com.example.testejsp.repository.TipoChamadoRepository;
import com.example.testejsp.repository.StatusChamadoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminConfigController {

    @Autowired private TipoChamadoRepository tipoChamadoRepository;
    @Autowired private StatusChamadoRepository statusChamadoRepository;

    @GetMapping("/tipos-chamado")
    public String listarTipos(Model model) {
        model.addAttribute("tipos", tipoChamadoRepository.findAll());
        return "admin-tipos-chamado";
    }

    @PostMapping("/tipos-chamado/salvar")
    public String salvarTipo(@RequestParam String titulo, @RequestParam Integer slaHoras) {
        TipoChamado tipo = new TipoChamado();
        tipo.setTitulo(titulo);
        tipo.setSlaHoras(slaHoras);
        tipoChamadoRepository.save(tipo);
        return "redirect:/admin/tipos-chamado?sucesso=true";
    }

    @GetMapping("/status")
    public String listarStatus(Model model) {
        model.addAttribute("statusList", statusChamadoRepository.findAll());
        return "admin-status";
    }

    @PostMapping("/status/salvar")
    public String salvarStatus(@RequestParam String nome) {
        StatusChamado status = new StatusChamado();
        status.setNome(nome);
        statusChamadoRepository.save(status);
        return "redirect:/admin/status?sucesso=true";
    }
}
