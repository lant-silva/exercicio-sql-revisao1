
CREATE DATABASE ex05
GO
USE ex05
GO
CREATE TABLE fornecedor(
codigo INT IDENTITY(1001, 1) NOT NULL,
nome VARCHAR(100) NOT NULL,
atividade VARCHAR(30) NOT NULL,
telefone CHAR(13) NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE produto(
codigo INT IDENTITY(1, 1) NOT NULL,
nome VARCHAR(50) NOT NULL,
valor_unitario DECIMAL(7, 2) NOT NULL,
quantidade_estoque INT NOT NULL,
descricão VARCHAR(100) NOT NULL,
codigo_fornecedor INT NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (codigo_fornecedor) REFERENCES fornecedor (codigo)
)
GO
CREATE TABLE cliente(
codigo INT IDENTITY(33601, 1) NOT NULL,
nome VARCHAR(100) NOT NULL,
logradouro VARCHAR(50) NOT NULL,
numero INT NOT NULL,
telefone CHAR(13) NOT NULL,
data_nasc DATE NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE pedido(
codigo INT NOT NULL,
codigo_cliente INT NOT NULL,
codigo_produto INT NOT NULL,
quantidade INT NOT NULL,
previsão_entrega DATE NOT NULL
PRIMARY KEY (codigo, codigo_cliente, codigo_produto)
FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo),
FOREIGN KEY (codigo_produto) REFERENCES produto (codigo)	
)

INSERT INTO fornecedor VALUES 
('Estrela',	'Brinquedo',	'41525898'),
('Lacta',	'Chocolate',	'42698596'),
('Asus',	'Informática',	'52014596'),
('Tramontina',	'Utensílios Domésticos',	'50563985'),
('Grow',	'Brinquedos',	'47896325'),
('Mattel',	'Bonecos',	'59865898')

INSERT INTO produto VALUES
('Banco Imobiliário',	65.00,	15,	'Versão Super Luxo',	1001),
('Puzzle 5000 peças',	50.00,	5,	'Mapas Mundo',	1005),
('Faqueiro',	350.00,	0,	'120 peças',	1004),
('Jogo para churrasco',	75.00,	3,	'7 peças',	1004),
('Tablet',	750.00,	29,	'Tablet',	1003),
('Detetive',	49.00,	0,	'Nova Versão do Jogo',	1001),
('Chocolate com Paçoquinha',	6.00,	0,	'Barra',	1002),
('Galak',	5.00,	65,	'Barra',	1002)

INSERT INTO cliente VALUES
('Maria Clara',	'R. 1° de Abril',	870,	'96325874',	'2000-08-15'),
('Alberto Souza',	'R. XV de Novembro',	987,	'95873625',	'1985-02-02'),
('Sonia Silva',	'R. Voluntários da Pátria',	1151,	'75418596',	'1957-08-23'),
('José Sobrinho',	'Av. Paulista',	250,	'85236547',	'1986-12-09'),
('Carlos Camargo',	'Av. Tiquatira',	9652,	'75896325',	'1971-03-25')

INSERT INTO pedido VALUES
(99001, 33601,	1,	1,	'2012-06-07'),
(99001, 33601,	2,	1,	'2012-06-07'),
(99001, 33601,	8,	3,	'2012-06-07'),
(99002, 33602,	2,	1,	'2012-06-09'),
(99002, 33602,	4,	3,	'2012-06-09'),
(99003, 33605,	5,	1,	'2012-06-15')

--Consultar a quantidade, valor total e valor total com desconto (25%) dos itens comprados par Maria Clara.
SELECT ped.quantidade, (ped.quantidade * pro.valor_unitario) AS valor_total, ((ped.quantidade * pro.valor_unitario) * 0.75) AS valor_desconto
FROM produto pro, pedido ped, cliente cli
WHERE ped.codigo_produto = pro.codigo
	AND ped.codigo_cliente = cli.codigo
	AND cli.nome LIKE 'Maria Clara'

--Alterar para reduzir em 10% o valor das barras de chocolate.
UPDATE produto
SET valor_unitario = valor_unitario * 0.90
WHERE descricão LIKE 'Barra'

--Alterar a quantidade em estoque do faqueiro para 10 peças.
UPDATE produto
SET quantidade_estoque = 10
WHERE nome LIKE 'Faqueiro'

--Consultar quantos clientes tem mais de 40 anos.
SELECT COUNT(nome) AS quantidade_clientes
FROM cliente
WHERE DATEDIFF(YEAR, data_nasc, GETDATE()) > 40 

--Consultar Nome e telefone dos fornecedores de Brinquedos e Chocolate.
SELECT nome, telefone
FROM fornecedor
WHERE atividade LIKE 'Brinquedo'
	OR atividade LIKE 'Chocolate'

--Consultar nome e desconto de 25% no preço dos produtos que custam menos de R$50,00
SELECT nome, (valor_unitario * 0.75) AS desconto
FROM produto
WHERE valor_unitario < 50

--Consultar nome e aumento de 10% no preço dos produtos que custam mais de R$100,00
SELECT nome, (valor_unitario * 1.10) AS aumento
FROM produto 
WHERE valor_unitario > 100

--Consultar desconto de 15% no valor total de cada produto da venda 99001.
SELECT ((ped.quantidade * pro.valor_unitario)*0.85) AS desconto
FROM pedido ped, produto pro
WHERE ped.codigo_produto = pro.codigo
	AND ped.codigo = 99001

--Consultar Código do pedido, nome do cliente e idade atual do cliente
SELECT ped.codigo, cli.nome, DATEDIFF(YEAR, cli.data_nasc, GETDATE()) AS idade_cliente
FROM pedido ped, cliente cli
WHERE ped.codigo_cliente = cli.codigo




