-- Criar a tabela de comentários
CREATE TABLE comentarios (
                             id BIGSERIAL PRIMARY KEY,
                             texto TEXT NOT NULL,
                             data_comentario TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                             chamado_id BIGINT NOT NULL REFERENCES chamados(id),
                             usuario_id BIGINT NOT NULL REFERENCES usuarios(id)
);

-- Adicionar coluna de data de finalização em chamados
ALTER TABLE chamados ADD COLUMN data_finalizacao TIMESTAMP WITHOUT TIME ZONE;