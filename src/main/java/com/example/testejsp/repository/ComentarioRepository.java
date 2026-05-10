package com.example.testejsp.repository;

import com.example.testejsp.model.Comentario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ComentarioRepository extends JpaRepository<Comentario, Long> {
    // Busca comentários de um chamado específico para montar o histórico
    List<Comentario> findByChamadoIdOrderByDataComentarioAsc(Long chamadoId);
}