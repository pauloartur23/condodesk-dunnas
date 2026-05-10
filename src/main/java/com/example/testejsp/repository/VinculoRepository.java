package com.example.testejsp.repository;

import com.example.testejsp.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Repositório para gestão de vínculos.
 * Como o vínculo está dentro da entidade Usuario (ManyToMany),
 * este repositório estende JpaRepository para a classe Usuario.
 */
@Repository
public interface VinculoRepository extends JpaRepository<Usuario, Long> {
}