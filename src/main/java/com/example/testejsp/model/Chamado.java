package com.example.testejsp.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "chamados")
public class Chamado {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titulo;

    @Column(columnDefinition = "TEXT")
    private String descricao;

    private String status;
    private String tipoChamado;
    private LocalDateTime dataAbertura;
    private LocalDateTime dataFinalizacao;

    @ManyToOne
    @JoinColumn(name = "unidade_id")
    private Unidade unidade;

    @OneToMany(mappedBy = "chamado", cascade = CascadeType.ALL)
    private List<Comentario> comentarios;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getTipoChamado() { return tipoChamado; }
    public void setTipoChamado(String tipoChamado) { this.tipoChamado = tipoChamado; }
    public LocalDateTime getDataAbertura() { return dataAbertura; }
    public void setDataAbertura(LocalDateTime d) { this.dataAbertura = d; }
    public LocalDateTime getDataFinalizacao() { return dataFinalizacao; }
    public void setDataFinalizacao(LocalDateTime d) { this.dataFinalizacao = d; }
    public Unidade getUnidade() { return unidade; }
    public void setUnidade(Unidade unidade) { this.unidade = unidade; }
    public List<Comentario> getComentarios() { return comentarios; }
    public void setComentarios(List<Comentario> c) { this.comentarios = c; }
}