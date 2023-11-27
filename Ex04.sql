CREATE DATABASE ex04
GO
USE ex04
GO
CREATE TABLE cliente(
cpf CHAR(11) NOT NULL,
nome VARCHAR(100) NOT NULL,
telefone CHAR(13) NOT NULL
PRIMARY KEY (cpf)
)
GO
CREATE TABLE fornecedor(
id INT IDENTITY(1, 1) NOT NULL,
nome VARCHAR(100) NOT NULL,
logradouro VARCHAR(50) NOT NULL,
numero INT NOT NULL,
complemento VARCHAR(50) NOT NULL,
cidade VARCHAR(50) NOT NULL	
PRIMARY KEY (id)
)
GO
CREATE TABLE produto(
codigo INT IDENTITY(1, 1) NOT NULL,
descricao VARCHAR(100) NOT NULL,
fornecedor INT NOT NULL,
preco DECIMAL(7, 2) NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (fornecedor) REFERENCES fornecedor (id)
)
GO
CREATE TABLE venda(
codigo INT NOT NULL,
produto INT NOT NULL,
cliente CHAR(11) NOT NULL,
quantidade INT NOT NULL,
valor_total DECIMAL(7, 2) NOT NULL,
data_venda DATE NOT NULL
PRIMARY KEY (codigo, produto, cliente)
FOREIGN KEY (produto) REFERENCES produto (codigo),
FOREIGN KEY (cliente) REFERENCES cliente (cpf)
)

INSERT INTO cliente VALUES 
('34578909290',	'Julio Cesar',	 '8273-6541'),
('25186533710',	'Maria Antonia', '8765-2314'),
('87627315416',	'Luiz Carlos',	 '6128-9012'),
('79182639800',	'Paulo Cesar',	 '9076-5273')

INSERT INTO fornecedor VALUES
('LG',	'Rod. Bandeirantes',	70000,	'Km 70',	'Itapeva'),
('Asus',	'Av. Nações Unidas',	10206,	'Sala 225',	'São Paulo'),
('AMD',	'Av. Nações Unidas',	10206,	'Sala 1095',	'São Paulo'),
('Leadership',	'Av. Nações Unidas',	10206,	'Sala 87',	'São Paulo'),
('Inno',	'Av. Nações Unidas',	10206,	'Sala 34',	'São Paulo')

INSERT INTO produto VALUES
('Monitor 19 pol.',	1,	449.99),
('Netbook 1GB Ram 4 Gb HD',	2,	699.99),
('Gravador de DVD - Sata',	1,	99.99),
('Leitor de CD',	1,	49.99),
('Processador - Phenom X3 - 2.1GHz',	3,	349.99),
('Mouse',	4,	19.99),
('Teclado',	4,	25.99),
('Placa de Video - Nvidia 9800 GTX - 256MB/256 bits',	5,	599.99)

INSERT INTO venda VALUES
(1,	1,	'25186533710',	1,	449.99,	 '2009-09-03'),
(1,	4,	'25186533710',	1,	49.99,	 '2009-09-03'),
(1,	5,	'25186533710',	1,	349.99,	 '2009-09-03'),
(2,	6,	'79182639800',	4,	79.96,	 '2009-09-06'),
(3,	8,	'87627315416',	1,	599.99,  '2009-09-06'),
(3,	3,	'87627315416',	1,	99.99,	 '2009-09-06'),
(3,	7,	'87627315416',	1,	25.99,   '2009-09-06'),
(4,	2,	'34578909290',	2,	1399.98, '2009-09-08')

ALTER TABLE fornecedor 
ADD telefone CHAR(13)
--Inserir na tabela Fornecedor, a coluna Telefone e os seguintes dados
--1	7216-5371
--2	8715-3738
--4	3654-6289
UPDATE fornecedor
SET telefone = '7216-5371'
WHERE id = 1

UPDATE fornecedor
SET telefone = '8715-3738'
WHERE id = 2

UPDATE fornecedor
SET telefone = '3654-6289'
WHERE id = 4
  
--Consultar no formato dd/mm/aaaa Data da Venda 4:
SELECT CONVERT(VARCHAR, data_venda, 103) as data_venda
FROM venda
WHERE codigo = 4

--Consultar por ordem alfabética de nome, o nome, o enderço concatenado e o telefone dos fornecedores
SELECT nome, (logradouro + ' ' + CAST(numero AS VARCHAR) + ' - ' + complemento + ' - ' + cidade) AS endereco
FROM fornecedor
ORDER BY nome ASC

--Produto, quantidade e valor total do comprado por Julio Cesar
SELECT produto, quantidade, valor_total
FROM venda
WHERE cliente IN(
	SELECT cpf
	FROM cliente
	WHERE nome LIKE 'Julio Cesar'
)

--Data, no formato dd/mm/aaaa e valor total do produto comprado por  Paulo Cesar
SELECT CONVERT(VARCHAR, data_venda, 103) AS data_venda, valor_total
FROM venda
WHERE cliente IN(
	SELECT cpf
	FROM cliente
	WHERE nome LIKE 'Julio Cesar'
)

--Consultar, em ordem decrescente, o nome e o preço de todos os produtos 
SELECT descricao, preco
FROM produto
ORDER BY descricao DESC
