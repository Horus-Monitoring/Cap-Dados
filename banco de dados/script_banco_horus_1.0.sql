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



 
 
 CREATE TABLE Servidor (
idServidor INT AUTO_INCREMENT,
data_instalacao DATE,
tag_servidor VARCHAR(45),
fk_empresa INT,
 CONSTRAINT pk_servidor_empresa
	PRIMARY KEY (idServidor, fk_empresa),
CONSTRAINT fk_empresa_registro_servidor
	FOREIGN KEY (fk_empresa)
		REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Componentes (
idComponentes INT PRIMARY KEY AUTO_INCREMENT,
nome_componente VARCHAR(45),
tipo_componente VARCHAR(45),
unidade_medida VARCHAR(45)
);


CREATE TABLE CompServidor (
id_componente_v INT AUTO_INCREMENT,
fk_componente INT,
fk_servidor INT,
limite VARCHAR(45),
CONSTRAINT pk_componente_servidor_componente_v
	PRIMARY KEY (id_componente_v, fk_componente, fk_servidor),
CONSTRAINT fk_componente_registro
	FOREIGN KEY (fk_componente)
		REFERENCES Componentes(idComponentes),
CONSTRAINT fk_servidor_registro
	FOREIGN KEY (fk_servidor)
		REFERENCES Servidor(idServidor)
);


CREATE TABLE Registro_Alerta (
idAlerta INT PRIMARY KEY AUTO_INCREMENT,
data_alerta DATETIME DEFAULT CURRENT_TIMESTAMP, 
criticidade VARCHAR(45), 
fk_servidor_componentes INT,
CONSTRAINT fk_servidor_componente
	FOREIGN KEY (fk_servidor_componentes)
		REFERENCES CompServidor(id_componente_v)
); 