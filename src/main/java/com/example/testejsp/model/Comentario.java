package com.example.testejsp.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "comentarios")
public class Comentario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "TEXT")
    private String texto;

    private LocalDateTime dataComentario;

    @ManyToOne
    @JoinColumn(name = "chamado_id")
    private Chamado chamado;

    @ManyToOne
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTexto() { return texto; }
    public void setTexto(String texto) { this.texto = texto; }
    public LocalDateTime getDataComentario() { return dataComentario; }
    public void setDataComentario(LocalDateTime d) { this.dataComentario = d; }
    public Chamado getChamado() { return chamado; }
    public void setChamado(Chamado chamado) { this.chamado = chamado; }
    public Usuario getUsuario() { return usuario; }
    public void setUsuario(Usuario usuario) { this.usuario = usuario; }
}