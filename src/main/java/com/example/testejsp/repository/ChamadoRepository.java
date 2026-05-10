package com.example.testejsp.repository;

import com.example.testejsp.model.Chamado;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ChamadoRepository extends JpaRepository<Chamado, Long> {
    List<Chamado> findByUnidadeUsuariosId(Long usuarioId);
}