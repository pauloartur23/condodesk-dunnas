package com.example.testejsp.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "unidades")
public class Unidade {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String numero;
    private Integer andar;

    @ManyToOne
    @JoinColumn(name = "bloco_id")
    private Bloco bloco;

    @ManyToMany(mappedBy = "unidades")
    private List<Usuario> usuarios;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNumero() { return numero; }
    public void setNumero(String numero) { this.numero = numero; }
    public Integer getAndar() { return andar; }
    public void setAndar(Integer andar) { this.andar = andar; }
    public Bloco getBloco() { return bloco; }
    public void setBloco(Bloco bloco) { this.bloco = bloco; }
    public List<Usuario> getUsuarios() { return usuarios; }
    public void setUsuarios(List<Usuario> usuarios) { this.usuarios = usuarios; }
}