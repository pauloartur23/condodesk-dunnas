package com.example.testejsp.repository;

import com.example.testejsp.model.Auditoria;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface AuditoriaRepository extends JpaRepository<Auditoria, Long> {
    List<Auditoria> findAllByOrderByDataHoraDesc();
}