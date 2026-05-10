package com.example.testejsp.model;

import jakarta.persistence.*;

@Entity
@Table(name = "blocos")
public class Bloco {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String identificacao;
    private Integer qtdAndares;
    private Integer aptosPorAndar;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getIdentificacao() { return identificacao; }
    public void setIdentificacao(String s) { this.identificacao = s; }
    public Integer getQtdAndares() { return qtdAndares; }
    public void setQtdAndares(Integer n) { this.qtdAndares = n; }
    public Integer getAptosPorAndar() { return aptosPorAndar; }
    public void setAptosPorAndar(Integer n) { this.aptosPorAndar = n; }
}