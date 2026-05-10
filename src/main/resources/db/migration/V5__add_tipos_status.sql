CREATE TABLE tipos_chamado (
    id BIGSERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    sla_horas INTEGER NOT NULL
);

CREATE TABLE status_chamado (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO status_chamado (nome) VALUES ('ABERTO');
INSERT INTO status_chamado (nome) VALUES ('EM_ATENDIMENTO');
INSERT INTO status_chamado (nome) VALUES ('CONCLUIDO');

INSERT INTO tipos_chamado (titulo, sla_horas) VALUES ('Manutenção', 48);
INSERT INTO tipos_chamado (titulo, sla_horas) VALUES ('Segurança', 24);
INSERT INTO tipos_chamado (titulo, sla_horas) VALUES ('Limpeza', 12);
INSERT INTO tipos_chamado (titulo, sla_horas) VALUES ('Barulho', 6);
INSERT INTO tipos_chamado (titulo, sla_horas) VALUES ('Outros', 72);

ALTER TABLE chamados ADD COLUMN IF NOT EXISTS tipo_chamado_id BIGINT REFERENCES tipos_chamado(id);
ALTER TABLE chamados ADD COLUMN IF NOT EXISTS status_id BIGINT REFERENCES status_chamado(id);