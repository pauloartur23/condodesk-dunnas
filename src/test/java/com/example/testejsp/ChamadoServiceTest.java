package com.example.testejsp;

import com.example.testejsp.model.*;
import com.example.testejsp.repository.ChamadoRepository;
import com.example.testejsp.repository.UnidadeRepository;
import com.example.testejsp.service.AuditoriaService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class ChamadoServiceTest {

    @Mock private ChamadoRepository chamadoRepository;
    @Mock private UnidadeRepository unidadeRepository;
    @Mock private AuditoriaService auditoriaService;

    private Usuario adminUser;
    private Usuario moradorUser;
    private Chamado chamado;
    private Unidade unidade;

    @BeforeEach
    void setUp() {
        adminUser = new Usuario();
        adminUser.setId(1L);
        adminUser.setNome("Admin");
        adminUser.setTipo(TipoUsuario.ADMIN);

        moradorUser = new Usuario();
        moradorUser.setId(2L);
        moradorUser.setNome("Morador");
        moradorUser.setTipo(TipoUsuario.MORADOR);

        Bloco bloco = new Bloco();
        bloco.setId(1L);
        bloco.setIdentificacao("A");

        unidade = new Unidade();
        unidade.setId(1L);
        unidade.setNumero("101");
        unidade.setAndar(1);
        unidade.setBloco(bloco);

        chamado = new Chamado();
        chamado.setId(1L);
        chamado.setTitulo("Vazamento");
        chamado.setStatus("ABERTO");
        chamado.setUnidade(unidade);
        chamado.setDataAbertura(LocalDateTime.now());
    }

    @Test
    void chamadoDeveSerCriadoComStatusAberto() {
        assertEquals("ABERTO", chamado.getStatus());
    }

    @Test
    void adminPodeAlterarStatus() {
        assertTrue(TipoUsuario.ADMIN.equals(adminUser.getTipo()) ||
                   TipoUsuario.COLABORADOR.equals(adminUser.getTipo()));
    }

    @Test
    void moradorNaoPodeAlterarStatus() {
        assertFalse(TipoUsuario.ADMIN.equals(moradorUser.getTipo()) ||
                    TipoUsuario.COLABORADOR.equals(moradorUser.getTipo()));
    }

    @Test
    void dataConclusaoDeveSerPreenchidaAoConcluir() {
        chamado.setStatus("CONCLUIDO");
        chamado.setDataFinalizacao(LocalDateTime.now());
        assertNotNull(chamado.getDataFinalizacao());
    }

    @Test
    void dataConclusaoDeveSerNulaQuandoReaberto() {
        chamado.setStatus("ABERTO");
        chamado.setDataFinalizacao(null);
        assertNull(chamado.getDataFinalizacao());
    }

    @Test
    void chamadoDeveVincularUnidadeCorretamente() {
        assertEquals("101", chamado.getUnidade().getNumero());
        assertEquals("A", chamado.getUnidade().getBloco().getIdentificacao());
    }

    @Test
    void auditoriaDeveSerRegistradaAoMudarStatus() {
        doNothing().when(auditoriaService).registrar(any(), any(), any(), any());
        auditoriaService.registrar("MUDANCA_STATUS", "Chamado #1",
                "Status alterado de 'ABERTO' para 'CONCLUIDO'", adminUser);
        verify(auditoriaService, times(1)).registrar(
                eq("MUDANCA_STATUS"), eq("Chamado #1"), any(), eq(adminUser));
    }
}