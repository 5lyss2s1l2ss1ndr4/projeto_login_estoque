CREATE DATABASE Projeto_Estoque

USE Projeto_Estoque
GO


create table estoque_insumos (
id_insumo int identity not null,
nome_insumo varchar(10),
lote_insumo varchar(10),
validade_insumo date,
qtd_insumo varchar(1000),
primary key (id_insumo)
)
go

create table usuario (
id_usuario int identity not null,
cpf_usuario varchar(15) unique not null,
nome_usuario varchar(50) not null,
lagradouro varchar (50),
login_usuario varchar(50) unique not null,
primary key (id_usuario)
)
go

create table login_estoque (
id_usuario int not null,
id_insumo int not null,
login_usuario varchar (50) not null,
senha_usuario varchar (MAX),
primary key (id_usuario, id_insumo),
foreign key (id_insumo) references estoque_insumos,
foreign key (id_usuario) references usuario
)
go


INSERT INTO usuario (cpf_usuario, nome_usuario, logradouro, login_usuario)
VALUES ('396.288.144-x', 'Ulysses Alessandro', 'Rua: Caicó', 'ulysses.alessandro10@gmail.com') 

INSERT INTO usuario (cpf_usuario, nome_usuario, logradouro, login_usuario)
VALUES ('411.410.618-x', 'Joice Alessandro', 'Rua: Colatina', 'joice_raiane@yahoo.com')
     
INSERT INTO usuario (cpf_usuario, nome_usuario, logradouro, login_usuario)
VALUES ('039.111.110-x', 'Joana Alessandro', 'Rua: Manuel Ribas', 'joaninha_linda@gmail.com')

INSERT INTO usuario (cpf_usuario, nome_usuario, logradouro, login_usuario)
VALUES ('333.230.118-X', 'Ulysses Alessandro', 'Rua: Caicó', 'ulysses_alessandro@hotmail.com')

-- CRIAR SMK
CREATE SYMMETRIC KEY smk_login_estoque
WITH ALGORITHM = AES_256 ENCRYPTION BY PASSWORD = 'ulysses020316';

-- ABRE SMK
OPEN SYMMETRIC KEY smk_login_estoque DECRYPTION BY PASSWORD = 'ulysses020316'

-- VERIFICA SMK
SELECT * FROM sys.openkeys;

-- LISTA AS CHAVES SIMÉTRICAS
SELECT * FROM sys.symmetric_keys;

-- INSERINDO NOVOS DADOS CRIPTOGRAFADOS
INSERT INTO login_estoque (id_usuario, id_insumo, login_usuario, senha_usuario)
VALUES ('3', '1', 'joice_raiane@yahoo.com', ENCRYPTBYKEY(KEY_GUID('smk_login_estoque'), 'marieta'));

INSERT INTO login_estoque (id_usuario, id_insumo, login_usuario, senha_usuario)
VALUES ('1', '2', 'ulysses.alessandro10@gmail.com', ENCRYPTBYKEY(KEY_GUID('smk_login_estoque'), 'maria'));

SELECT * FROM login_estoque

SELECT * FROM estoque_insumos

SELECT * FROM usuario

SELECT *,
CONVERT(VARCHAR, DECRYPTBYKEY(senha_usuario)) AS [SENHA_CODIFICADA]
FROM login_estoque;

-- FECHAR SMK
CLOSE SYMMETRIC KEY smk_login_estoque

-- EXCLUIR UMA CHAVE SMK
DROP SYMMETRIC KEY smk_login_estoque

-- HABILITANDO/DESABILITANDO O TRUNCAMENTO
SET ANSI_WARNINGS OFF;
-- Your insert TSQL here.
SET ANSI_WARNINGS ON;

-- DADOS SEM CRIPTOGRAFIA PARA TESTES
INSERT INTO login_estoque (id_usuario, id_insumo, login_usuario, senha_usuario)
VALUES ('4', '2', 'ulysses.alessandro@gmail.com', 'marieta')