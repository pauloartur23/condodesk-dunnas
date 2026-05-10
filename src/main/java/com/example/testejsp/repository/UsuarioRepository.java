package com.example.testejsp.repository; // Se estiver na pasta repository

import com.example.testejsp.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    Usuario findByEmailAndSenha(String email, String senha);
}