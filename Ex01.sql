CREATE DATABASE ex1
USE ex1

CREATE TABLE aluno(
ra			INT				NOT NULL,
nome		VARCHAR(20)		NOT NULL,
sobrenome	VARCHAR(30)		NOT NULL,
rua 		VARCHAR(70)		NOT NULL,
numero		INT				NOT NULL,
bairro		VARCHAR(50)		NOT NULL,
cep			INT 			NOT NULL,
telefone	VARCHAR(8)		NULL
PRIMARY KEY(ra)
)

CREATE TABLE disciplina(
codigo		INT				NOT NULL	IDENTITY(1,1),
nome		VARCHAR(50)		NOT NULL,
carga		INT 			NOT NULL,
turno		VARCHAR(10)		NOT NULL,
semestre	INT 			NOT NULL
PRIMARY KEY(codigo)
)

CREATE TABLE curso(
codigo		INT 			NOT NULL	IDENTITY(1,1),
nome		VARCHAR(50)		NOT NULL,
carga		INT				NOT NULL,
turno		VARCHAR(10)		NOT NULL
PRIMARY KEY(codigo)
)

INSERT INTO aluno VALUES
(12345, 'José', 'Silva', 'Almirante Noronha', 236, 'Jardim São Paulo', '1589000', '69875287'),
(12346, 'Ana', 'Maria Bastos', 'Anhaia', 1568, 'Barra Funda', '3569000', '25698526'),
(12347, 'Mario', 'Santos', 'XV de Novembro', 1841, 'Centro', '1020030', NULL),
(12348, 'Marcia', 'Neves', 'Voluntários da Patria', 225, 'Santana', '2785090', '78964152')

INSERT INTO curso VALUES
('Informática', 2800, 'Tarde'),
('Informática', 2800, 'Noite'),
('Logística', 2650, 'Tarde'),
('Logística', 2650, 'Noite'),
('Plásticos', 2500, 'Tarde'),
('Plásticos', 2500, 'Noite')

INSERT INTO disciplina VALUES
('Informática', 4, 'Tarde', 1),
('Informática', 4, 'Noite', 1),
('Quimica', 4, 'Tarde', 1),
('Quimica', 4, 'Noite', 1),
('Banco de Dados I', 2, 'Tarde', 3),
('Banco de Dados I', 2, 'Noite', 3),
('Estrutura de Dados', 4, 'Tarde', 4),
('Estrutura de Dados', 4, 'Noite', 4)

--Nome e sobrenome, como nome completo dos Alunos Matriculados
SELECT (nome + ' ' +sobrenome) AS alunoMatriculado
FROM aluno

--Rua, nº , Bairro e CEP como Endereço do aluno que não tem telefone
SELECT (rua + ' ' + CAST(numero AS VARCHAR) + ' - ' + bairro + ' - ' + CAST(cep AS VARCHAR)) AS endereco 
FROM aluno 
WHERE telefone IS NULL

--Telefone do aluno com RA 12348
SELECT telefone
FORM aluno
WHERE ra = 12348

--Nome e Turno dos cursos com 2800 horas
SELECT nome, turno
FROM curso
WHERE carga = 2800

--O semestre do curso de Banco de Dados I noite
SELECT semestre
FROM disciplina
WHERE turno = 'Noite' AND nome = 'Banco de Dados I'

