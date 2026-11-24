-- ==============================================================================
-- PROJETO: Sistema de Biblioteca
-- ARQUIVO: script-ddl.sql (Data Definition Language)
-- OBJETIVO: Criação da estrutura do banco de dados, tabelas e restrições.
-- ==============================================================================

-- 1. Tabela: CATEGORIA
-- Tabela pai, independente.
CREATE TABLE Categoria (
    id_categoria INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE, -- Restrição UNIQUE para não ter categorias com mesmo nome
    descricao VARCHAR(255),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Restrição DEFAULT para registrar a hora exata
);

-- 2. Tabela: AUTOR
-- Tabela pai, independente.
CREATE TABLE Autor (
    id_autor INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50),
    data_nascimento DATE
);

-- 3. Tabela: EDITORA
-- Tabela pai, independente.
CREATE TABLE Editora (
    id_editora INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50),
    telefone_contato VARCHAR(20)
);

-- 4. Tabela: USUARIO
-- Tabela pai, independente.
CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    data_cadastro DATE NOT NULL
);

-- 5. Tabela: FUNCIONARIO
-- Tabela pai, independente. (Quem realiza o empréstimo)
CREATE TABLE Funcionario (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    data_admissao DATE
);

-- 6. Tabela: LIVRO
-- Tabela filha. Depende de Categoria, Autor e Editora.
CREATE TABLE Livro (
    id_livro INT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    ano_publicacao INT CHECK (ano_publicacao > 1400), -- Restrição CHECK: ano deve ser válido
    isbn VARCHAR(20),
    id_categoria INT NOT NULL,
    id_autor INT NOT NULL,
    id_editora INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
    FOREIGN KEY (id_autor) REFERENCES Autor(id_autor),
    FOREIGN KEY (id_editora) REFERENCES Editora(id_editora)
);

-- 7. Tabela: EMPRESTIMO
-- Tabela filha. Depende de Livro, Usuario e Funcionario.
CREATE TABLE Emprestimo (
    id_emprestimo INT PRIMARY KEY,
    id_livro INT NOT NULL,
    id_usuario INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_retirada DATE NOT NULL,
    data_devolucao_prevista DATE NOT NULL,
    data_devolucao_real DATE,
    status VARCHAR(20) DEFAULT 'Ativo' CHECK (status IN ('Ativo', 'Devolvido', 'Atrasado')), -- Restrição CHECK
    FOREIGN KEY (id_livro) REFERENCES Livro(id_livro),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario)
);

-- 8. Tabela: MULTA
-- Tabela filha. Depende de Emprestimo.
CREATE TABLE Multa (
    id_multa INT PRIMARY KEY,
    id_emprestimo INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL CHECK (valor >= 0), -- Restrição CHECK: valor não pode ser negativo
    data_geracao DATE NOT NULL,
    status_pagamento VARCHAR(20) DEFAULT 'Pendente',
    FOREIGN KEY (id_emprestimo) REFERENCES Emprestimo(id_emprestimo)
);
