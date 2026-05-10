package com.example.testejsp.model;

import jakarta.persistence.*;

@Entity
@Table(name = "tipos_chamado")
public class TipoChamado {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String titulo;
    private Integer slaHoras;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public Integer getSlaHoras() { return slaHoras; }
    public void setSlaHoras(Integer slaHoras) { this.slaHoras = slaHoras; }
}