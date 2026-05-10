package com.example.testejsp;

import com.example.testejsp.model.TipoUsuario;
import com.example.testejsp.model.Usuario;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class UsuarioTest {

    @Test
    void usuarioAdminDeveSerIdentificadoCorretamente() {
        Usuario u = new Usuario();
        u.setTipo(TipoUsuario.ADMIN);
        assertEquals(TipoUsuario.ADMIN, u.getTipo());
    }

    @Test
    void usuarioMoradorDeveSerIdentificadoCorretamente() {
        Usuario u = new Usuario();
        u.setTipo(TipoUsuario.MORADOR);
        assertEquals(TipoUsuario.MORADOR, u.getTipo());
    }

    @Test
    void usuarioColaboradorDeveSerIdentificadoCorretamente() {
        Usuario u = new Usuario();
        u.setTipo(TipoUsuario.COLABORADOR);
        assertEquals(TipoUsuario.COLABORADOR, u.getTipo());
    }

    @Test
    void emailNaoDeveSerNulo() {
        Usuario u = new Usuario();
        u.setEmail("teste@teste.com");
        assertNotNull(u.getEmail());
    }

    @Test
    void nomeDeveSerAtribuido() {
        Usuario u = new Usuario();
        u.setNome("Paulo Artur");
        assertEquals("Paulo Artur", u.getNome());
    }
}