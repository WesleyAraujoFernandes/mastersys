CREATE TABLE alunos(
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo VARCHAR(1) CHECK (sexo IN ('M', 'F')),
    telefone VARCHAR(30),
    celular VARCHAR(30),
    email VARCHAR(150) UNIQUE,
    observacoes TEXT,
    endereco VARCHAR(150),
    numero VARCHAR(20),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    cep VARCHAR(20),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP
)

CREATE TABLE modalidades(
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP
)

CREATE TABLE graduacoes(
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    modalidade_id BIGINT NOT NULL REFERENCES modalidades(id) ON DELETE CASCADE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP,
    UNIQUE (modalidade_id, nome)
)

CREATE TABLE planos(
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    valor_mensal NUMERIC(10, 2) NOT NULL CHECK (valor_mensal >= 0),
    modalidade_id BIGINT NOT NULL REFERENCES modalidades(id) ON DELETE CASCADE,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE (modalidade_id, nome)
)

CREATE TABLE matriculas(
    id BIGSERIAL PRIMARY KEY,
    aluno_id BIGINT NOT NULL REFERENCES alunos(id) ON DELETE CASCADE,
    data_matricula DATE NOT NULL DEFAULT CURRENT_DATE,
    dia_vencimento INT NOT NULL CHECK (dia_vencimento BETWEEN 1 AND 31),
    data_encerramento DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'ATIVA' CHECK (status IN ('ATIVA', 'ENCERRADA', 'CANCELADA'))
)

CREATE TABLE matricula_modalidades(
    id BIGSERIAL PRIMARY KEY,
    matricula_id BIGINT NOT NULL REFERENCES matriculas(id) ON DELETE CASCADE,
    modalidade_id BIGINT NOT NULL REFERENCES modalidades(id) ON DELETE CASCADE,
    graduacao_id BIGINT NOT NULL REFERENCES graduacoes(id) ON DELETE CASCADE, 
    plano_id BIGINT NOT NULL REFERENCES planos(id) ON DELETE CASCADE,
    data_inicio DATE NOT NULL DEFAULT CURRENT_DATE,
    data_fim DATE,
    UNIQUE (matricula_id, modalidade_id)
)

CREATE TABLE faturas_matriculas(
    id BIGSERIAL PRIMARY KEY,
    matricula_id BIGINT NOT NULL REFERENCES matriculas(id) ON DELETE CASCADE,
    valor NUMERIC(10, 2) NOT NULL CHECK (valor >= 0),
    data_vencimento DATE NOT NULL,
    data_pagamento TIMESTAMP,
    data_cancelamento DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'ABERTA' CHECK (status IN ('ABERTA', 'PAGA', 'CANCELADA', 'VENCIDA')),
    UNIQUE (matricula_id, data_vencimento)
)

CREATE TABLE assiduidade(
    id BIGSERIAL PRIMARY KEY,
    matricula_id BIGINT NOT NULL REFERENCES matriculas(id) ON DELETE CASCADE,
    data_entrada TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_saida TIMESTAMP
)