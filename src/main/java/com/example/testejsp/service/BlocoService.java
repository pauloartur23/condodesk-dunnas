package com.example.testejsp.service;

import com.example.testejsp.model.Bloco;
import com.example.testejsp.model.Unidade;
import com.example.testejsp.repository.BlocoRepository;
import com.example.testejsp.repository.UnidadeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class BlocoService {

    @Autowired
    private BlocoRepository blocoRepository;

    @Autowired
    private UnidadeRepository unidadeRepository;

    @Transactional
    public void salvarEGerarUnidades(Bloco bloco) {
        // 1. Salva o bloco primeiro
        blocoRepository.save(bloco);

        // 2. Loop para gerar as unidades conforme o desafio
        for (int i = 1; i <= bloco.getQtdAndares(); i++) {
            for (int j = 1; j <= bloco.getAptosPorAndar(); j++) {
                Unidade unidade = new Unidade();

                // Padrão consistente: Andar + Número do Apto (Ex: 101, 102...)
                String numeroApto = i + String.format("%02d", j);

                unidade.setNumero(numeroApto);
                unidade.setAndar(i);
                unidade.setBloco(bloco); // Vincula ao bloco recém-criado

                unidadeRepository.save(unidade);
            }
        }
    }
}