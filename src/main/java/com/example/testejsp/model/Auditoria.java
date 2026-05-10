package com.example.testejsp.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "auditorias")
public class Auditoria {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String acao;
    private String entidade;
    private String detalhes;
    private LocalDateTime dataHora;

    @ManyToOne
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getAcao() { return acao; }
    public void setAcao(String acao) { this.acao = acao; }
    public String getEntidade() { return entidade; }
    public void setEntidade(String entidade) { this.entidade = entidade; }
    public String getDetalhes() { return detalhes; }
    public void setDetalhes(String detalhes) { this.detalhes = detalhes; }
    public LocalDateTime getDataHora() { return dataHora; }
    public void setDataHora(LocalDateTime d) { this.dataHora = d; }
    public Usuario getUsuario() { return usuario; }
    public void setUsuario(Usuario usuario) { this.usuario = usuario; }
}