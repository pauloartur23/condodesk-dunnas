INSERT INTO usuarios (nome, email, senha, tipo)
VALUES ('Administrador', 'admin@admin.com', '123456', 'ADMIN')
ON CONFLICT (email) DO NOTHING;

INSERT INTO usuarios (nome, email, senha, tipo)
VALUES ('Morador Teste', 'morador@teste.com', '123456', 'MORADOR')
ON CONFLICT (email) DO NOTHING;

INSERT INTO usuarios (nome, email, senha, tipo)
VALUES ('Colaborador Teste', 'colaborador@teste.com', '123456', 'COLABORADOR')
ON CONFLICT (email) DO NOTHING;