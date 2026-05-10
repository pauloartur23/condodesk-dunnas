package com.example.testejsp.service;

import com.example.testejsp.model.Auditoria;
import com.example.testejsp.model.Usuario;
import com.example.testejsp.repository.AuditoriaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class AuditoriaService {

    @Autowired
    private AuditoriaRepository auditoriaRepository;

    public void registrar(String acao, String entidade, String detalhes, Usuario usuario) {
        Auditoria a = new Auditoria();
        a.setAcao(acao);
        a.setEntidade(entidade);
        a.setDetalhes(detalhes);
        a.setUsuario(usuario);
        a.setDataHora(LocalDateTime.now());
        auditoriaRepository.save(a);
    }
}