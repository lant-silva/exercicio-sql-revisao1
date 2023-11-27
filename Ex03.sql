CREATE DATABASE ex03
GO
USE ex03
GO
CREATE TABLE paciente(
cpf CHAR(11) NOT NULL,
nome VARCHAR(100) NOT NULL,
rua VARCHAR(50) NOT NULL,
numero INT NOT NULL,
bairro VARCHAR(30) NOT NULL,
telefone CHAR(13) NULL,
data_nasc DATE NOT NULL
PRIMARY KEY (cpf)
)
GO
CREATE TABLE medico(
codigo INT IDENTITY(1, 1) NOT NULL,
nome VARCHAR(100) NOT NULL,
especialidade VARCHAR(30) NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE prontuario(
data_prontuario DATE NOT NULL,
cpf_paciente CHAR(11) NOT NULL,
codigo_medico INT NOT NULL,
diagnostico VARCHAR(100) NOT NULL,
medicamento VARCHAR(30) NOT NULL
PRIMARY KEY (data_prontuario, cpf_paciente, codigo_medico)
FOREIGN KEY (cpf_paciente) REFERENCES paciente (cpf),
FOREIGN KEY (codigo_medico) REFERENCES medico (codigo)
)
GO
INSERT INTO paciente VALUES
('35454562890',	'José Rubens',	'Campos Salles',	2750,	'Centro',	'21450998',	'1954-10-18'),
('29865439810',	'Ana Claudia',	'Sete de Setembro',	178,	'Centro',	'97382764',	'1960-05-29'),
('82176534800',	'Marcos Aurélio',	'Timóteo Penteado',	236,	'Vila Galvão',	'68172651',	'1980-09-24'),
('12386758770',	'Maria Rita',	'Castello Branco',	7765,	'Vila Rosália',	NULL,	'1975-03-30'),
('92173458910',	'Joana de Souza',	'XV de Novembro',	298,	'Centro',	'21276578',	'1944-04-24')
GO
INSERT INTO medico VALUES
('Wilson Cesar',	'Pediatra'),
('Marcia Matos',	'Geriatra'),
('Carolina Oliveira',	'Ortopedista'),
('Vinicius Araujo',	'Clínico Geral')
GO
INSERT INTO prontuario VALUES
('2020-09-10',	'35454562890',	2,	'Reumatismo',	'Celebra'),
('2020-09-10',	'92173458910',	2,	'Renite', 'Alérgica	Allegra'),
('2020-09-12',	'29865439810',	1,	'Inflamação de garganta',	'Nimesulida'),
('2020-09-13',	'35454562890',	2,	'H1N1',	'Tamiflu'),
('2020-09-15',	'82176534800',	4,	'Gripe',	'Resprin'),
('2020-09-15',	'12386758770',	3,	'Braço Quebrado',	'Dorflex + Gesso')

--Nome e Endereço (concatenado) dos pacientes com mais de 50 anos
SELECT nome, (rua + ' ' + CAST(numero AS VARCHAR) + ' ' + bairro) AS endereco
FROM paciente
WHERE DATEDIFF(YEAR, data_nasc, GETDATE()) > 50

--Qual a especialidade de Carolina Oliveira
SELECT especialidade
FROM medico
WHERE nome = 'Carolina Oliveira'

--Qual medicamento receitado para reumatismo
SELECT medicamento
FROM prontuario
WHERE diagnostico = 'Reumatismo'

--Diagnóstico e Medicamento do paciente José Rubens em suas consultas
SELECT diagnostico, medicamento
FROM prontuario
WHERE cpf_paciente IN(
	SELECT cpf
	FROM paciente
	WHERE nome = 'José Rubens'
)

--Nome e especialidade do(s) Médico(s) que atenderam José Rubens. Caso a especialidade tenha mais de 3 letras, mostrar apenas as 3 primeiras letras concatenada com um ponto final (.)
SELECT nome, CASE WHEN(LEN(especialidade) > 3) THEN
	SUBSTRING(especialidade, 1, 3) + '.' END AS especialidade
FROM medico
WHERE codigo IN(
	SELECT codigo_medico
	FROM prontuario
	WHERE cpf_paciente IN(
		SELECT cpf
		FROM paciente
		WHERE nome = 'José Rubens'
	)
)

--CPF (Com a máscara XXX.XXX.XXX-XX), Nome, Endereço completo (Rua, nº - Bairro), Telefone (Caso nulo, mostrar um traço (-)) dos pacientes do médico Vinicius
SELECT (SUBSTRING(cpf, 1, 3) + '.' + SUBSTRING(cpf, 4, 3) + '.' + SUBSTRING(cpf, 7, 3) + '-' + SUBSTRING(cpf, 10, 2)) AS cpf,
	nome, (rua + ' ' + CAST(numero AS VARCHAR) + ' ' + bairro) AS endereco,
	CASE WHEN(telefone IS NULL) THEN
	' - ' ELSE telefone END AS telefone
FROM paciente
WHERE cpf IN(
	SELECT cpf_paciente
	FROM prontuario
	WHERE codigo_medico IN(
		SELECT codigo
		FROM medico
		WHERE nome LIKE 'Vinicius%'
	)
)

--Quantos dias fazem da consulta de Maria Rita até hoje
SELECT DATEDIFF(DAY, data_prontuario, GETDATE()) AS dias
FROM prontuario
WHERE cpf_paciente in(
	SELECT cpf
	FROM paciente
	WHERE nome = 'Maria Rita'
)

--Alterar o telefone da paciente Maria Rita, para 98345621
UPDATE paciente
SET telefone = '98345621'
WHERE nome LIKE 'Maria Rita'

--Alterar o Endereço de Joana de Souza para Voluntários da Pátria, 1980, Jd. Aeroporto
UPDATE paciente
SET rua = 'Voluntários da Pátria', numero = 1980, bairro = 'Jd. Aeroporto'
WHERE nome LIKE 'Joana de Souza'
