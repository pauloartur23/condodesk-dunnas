package com.example.testejsp.repository;

import com.example.testejsp.model.StatusChamado;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StatusChamadoRepository extends JpaRepository<StatusChamado, Long> {
}