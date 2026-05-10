package com.example.testejsp.repository;

import com.example.testejsp.model.TipoChamado;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TipoChamadoRepository extends JpaRepository<TipoChamado, Long> {
}