CREATE TABLE auditorias (
    id BIGSERIAL PRIMARY KEY,
    acao VARCHAR(100) NOT NULL,
    entidade VARCHAR(255),
    detalhes TEXT,
    data_hora TIMESTAMP,
    usuario_id BIGINT REFERENCES usuarios(id)
);