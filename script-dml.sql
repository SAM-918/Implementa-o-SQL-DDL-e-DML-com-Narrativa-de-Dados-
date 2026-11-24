-- PROJETO: Sistema de Biblioteca

-- ARQUIVO: script-dml.sql (Data Manipulation Language)


INSERT INTO Autor (id_autor, nome, nacionalidade, data_nascimento) VALUES
(1, 'Frank Herbert', 'Americano', '1920-10-08'),
(2, 'Jane Austen', 'Britânica', '1775-12-16'),
(3, 'Stephen King', 'Americano', '1947-09-21'),
(4, 'Walter Isaacson', 'Americano', '1952-05-20'),
(5, 'Kathy Sierra', 'Americana', '1963-01-01');






INSERT INTO Editora (id_editora, nome, cidade, telefone_contato) VALUES
(1, 'Aleph', 'São Paulo', '11-5555-1000'),
(2, 'Martin Claret', 'São Paulo', '11-5555-2000'),
(3, 'Suma', 'Rio de Janeiro', '21-5555-3000'),
(4, 'Companhia das Letras', 'São Paulo', '11-5555-4000'),
(5, 'Alta Books', 'Rio de Janeiro', '21-5555-5000');






INSERT INTO Categoria (id_categoria, nome, descricao) VALUES
(1, 'Ficção Científica', 'Livros sobre futuros, tecnologia e espaço'),
(2, 'Romance', 'Histórias de amor e relacionamentos'),
(3, 'Terror', 'Livros para assustar e suspense'),
(4, 'Biografia', 'Histórias de vida reais'),
(5, 'Tecnologia', 'Livros de programação e TI');



INSERT INTO Funcionario (id_funcionario, nome, cargo, data_admissao) VALUES
(1, 'Mariana Costa', 'Gerente', '2023-01-02'),
(2, 'Pedro Santos', 'Bibliotecário', '2023-01-05'),
(3, 'Lucas Pereira', 'Atendente', '2023-01-10'),
(4, 'Julia Almeida', 'Atendente', '2023-01-10'),
(5, 'Carlos Eduardo', 'Estagiário', '2023-02-01');



INSERT INTO Livro (id_livro, titulo, ano_publicacao, isbn, id_categoria, id_autor, id_editora) VALUES
(1, 'Duna', 1965, '978-8576573006', 1, 1, 1),
(2, 'Orgulho e Preconceito', 1813, '978-8572327869', 2, 2, 2),
(3, 'O Iluminado', 1977, '978-8566512004', 3, 3, 3),
(4, 'Steve Jobs', 2011, '978-8535919710', 4, 4, 4),
(5, 'Use a Cabeça! Java', 2005, '978-8576083625', 5, 5, 5);



-- -- No primeiro dia de funcionamento, cinco moradores do bairro se cadastraram  no sistema para poderem levar livros para casa.


INSERT INTO Usuario (id_usuario, nome, email, telefone, data_cadastro) VALUES
(1, 'José Silva', 'jose.silva@email.com', '11-99999-1111', '2023-02-10'),
(2, 'Maria Oliveira', 'maria.oliveira@email.com', '11-99999-2222', '2023-02-10'),
(3, 'Ana Souza', 'ana.souza@email.com', '11-99999-3333', '2023-02-10'),
(4, 'Bruno Lima', 'bruno.lima@email.com', '11-99999-4444', '2023-02-11'),
(5, 'Carla Dias', 'carla.dias@email.com', '11-99999-5555', '2023-02-11');



-- Cenário 3 — Início das Operações de Empréstimo
-- -- O sistema começa a rodar. José e Maria levam livros emprestados.



-- José levou "Duna" emprestado no dia 12/02. Prazo de 15 dias. Atendido por Pedro.
INSERT INTO Emprestimo (id_emprestimo, id_livro, id_usuario, id_funcionario, data_retirada, data_devolucao_prevista, data_devolucao_real, status) VALUES
(1, 1, 1, 2, '2023-02-12', '2023-02-27', NULL, 'Ativo');

-- Maria levou "Orgulho e Preconceito". Atendida por Lucas.
INSERT INTO Emprestimo (id_emprestimo, id_livro, id_usuario, id_funcionario, data_retirada, data_devolucao_prevista, data_devolucao_real, status) VALUES
(2, 2, 2, 3, '2023-02-13', '2023-02-28', NULL, 'Ativo');

-- Ana levou "Use a Cabeça! Java". Atendida por Julia.
INSERT INTO Emprestimo (id_emprestimo, id_livro, id_usuario, id_funcionario, data_retirada, data_devolucao_prevista, data_devolucao_real, status) VALUES
(3, 5, 3, 4, '2023-02-14', '2023-03-01', NULL, 'Ativo');

-- Bruno levou "O Iluminado". Atendido por Pedro.
INSERT INTO Emprestimo (id_emprestimo, id_livro, id_usuario, id_funcionario, data_retirada, data_devolucao_prevista, data_devolucao_real, status) VALUES
(4, 3, 4, 2, '2023-02-15', '2023-03-02', NULL, 'Ativo');

-- Carla levou "Steve Jobs", leu rápido e já devolveu. Atendida por Lucas.
INSERT INTO Emprestimo (id_emprestimo, id_livro, id_usuario, id_funcionario, data_retirada, data_devolucao_prevista, data_devolucao_real, status) VALUES
(5, 4, 5, 3, '2023-02-15', '2023-03-02', '2023-02-20', 'Devolvido');

-- 
-- Cenário 4 — Atrasos e Aplicação de Multas
-- -- José não devolveu o livro "Duna" no prazo. O sistema gera a multa.


INSERT INTO Multa (id_multa, id_emprestimo, valor, data_geracao, status_pagamento) VALUES
(1, 1, 5.50, '2023-02-28', 'Pendente');

-- Supondo que outros empréstimos fictícios atrasaram e geraram multas:
INSERT INTO Multa (id_multa, id_emprestimo, valor, data_geracao, status_pagamento) VALUES
(2, 2, 2.00, '2023-03-01', 'Pago'),
(3, 3, 1.50, '2023-03-02', 'Pendente'),
(4, 4, 4.00, '2023-03-03', 'Pendente'),
(5, 5, 0.00, '2023-02-21', 'Isento'); -- Carla devolveu no prazo, multa zerada por garantia de sistema.
