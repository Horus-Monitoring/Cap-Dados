CREATE DATABASE horus_db;

USE horus_db;

CREATE TABLE Papel (
idPapel INT PRIMARY KEY AUTO_INCREMENT,
nivel VARCHAR(45),
descricao VARCHAR(80)
);


CREATE TABLE Localizacao (
idLocalizacao INT PRIMARY KEY AUTO_INCREMENT,
uf CHAR(2),
cidade VARCHAR(45),
bairro VARCHAR(45),
logradouro VARCHAR(45),
numero INT,
cep CHAR(11)
);


CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
razao_social VARCHAR(45),
cnpj CHAR(15) NOT NULL UNIQUE,
telefone_empresa CHAR(11) NOT NULL UNIQUE,
token_empresa CHAR(8) NOT NULL UNIQUE,
fk_localizacao INT,
CONSTRAINT fk_localizacao_registro
	FOREIGN KEY (fk_localizacao)
		REFERENCES Localizacao(idLocalizacao)
);



CREATE TABLE Funcionario (
idFuncionario INT AUTO_INCREMENT,
fk_empresa INT,
nome VARCHAR(45),
cpf CHAR(11) NOT NULL UNIQUE,
email VARCHAR(45) NOT NULL UNIQUE,
senha VARCHAR(45),
fk_papel INT,
CONSTRAINT pk_funcionario_empresa
	PRIMARY KEY(idFuncionario, fk_empresa),
CONSTRAINT fk_empresa_registro
	FOREIGN KEY (fk_empresa)
		REFERENCES Empresa(idEmpresa),
CONSTRAINT fk_papel_registro
	FOREIGN KEY (fk_papel)
		REFERENCES Papel(idPapel)
);


CREATE TABLE Componentes (
idComponentes INT PRIMARY KEY AUTO_INCREMENT,
modelo_servidor VARCHAR(45),
so_servidor VARCHAR(45),
qtd_ram INT,
qtd_nucleos_cpu INT,
qtd_disco INT
);



 
 
 CREATE TABLE Servidor (
idServidor INT AUTO_INCREMENT,
data_instalacao DATE,
fk_empresa INT,
fk_componentes INT,
CONSTRAINT pk_servidor_empresa
	PRIMARY KEY (idServidor, fk_empresa),
CONSTRAINT fk_empresa_registro_servidor 
	FOREIGN KEY (fk_empresa)
		REFERENCES Empresa(idEmpresa),
CONSTRAINT fk_componentes_registro_servidor
	FOREIGN KEY (fk_componentes)
		REFERENCES Componentes(idComponentes)
);




CREATE TABLE Alerta (
idAlerta INT PRIMARY KEY AUTO_INCREMENT,
data_alerta DATETIME DEFAULT CURRENT_TIMESTAMP, 
criticidade VARCHAR(45), 
fk_componentes INT,
CONSTRAINT fk_componentes_registro
	FOREIGN KEY (fk_componentes)
		REFERENCES Componentes(idComponentes)
); 