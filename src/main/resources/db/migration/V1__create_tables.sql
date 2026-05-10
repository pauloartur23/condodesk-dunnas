CREATE TABLE usuarios (
                          id BIGSERIAL PRIMARY KEY,
                          nome VARCHAR(255) NOT NULL,
                          email VARCHAR(255) UNIQUE NOT NULL,
                          senha VARCHAR(255) NOT NULL,
                          tipo VARCHAR(255) NOT NULL
);

CREATE TABLE blocos (
                        id BIGSERIAL PRIMARY KEY,
                        identificacao VARCHAR(255) NOT NULL,
                        qtd_andares INTEGER NOT NULL,
                        aptos_por_andar INTEGER NOT NULL
);

CREATE TABLE unidades (
                          id BIGSERIAL PRIMARY KEY,
                          numero VARCHAR(255) NOT NULL,
                          andar INTEGER NOT NULL,
                          bloco_id BIGINT REFERENCES blocos(id)
);

CREATE TABLE chamados (
                          id BIGSERIAL PRIMARY KEY,
                          titulo VARCHAR(255),
                          descricao TEXT,
                          status VARCHAR(255) DEFAULT 'ABERTO',
                          data_abertura TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                          unidade_id BIGINT REFERENCES unidades(id)
);

CREATE TABLE usuario_unidades (
                                  usuario_id BIGINT REFERENCES usuarios(id),
                                  unidade_id BIGINT REFERENCES unidades(id),
                                  PRIMARY KEY (usuario_id, unidade_id)
);