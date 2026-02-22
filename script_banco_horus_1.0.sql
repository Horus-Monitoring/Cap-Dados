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


CREATE TABLE Datacenter (
idDatacenter INT AUTO_INCREMENT,
fk_empresa INT,
qtd_comp INT,
data_instalacao DATE,
fk_localizacao INT,
CONSTRAINT pk_datacenter_empresa
	PRIMARY KEY(idDatacenter, fk_empresa),
CONSTRAINT fk_empresa_registro_datacenter
	FOREIGN KEY (fk_empresa)
		REFERENCES Empresa(idEmpresa),
CONSTRAINT fk_localizacao_registro_datacenter
	FOREIGN KEY (fk_localizacao)
		REFERENCES Localizacao (idLocalizacao)
 );
 
 
 CREATE TABLE Servidor (
 idServidor INT AUTO_INCREMENT,
 fk_datacenter INT,
 so VARCHAR(45),
 modelo_servidor VARCHAR(45),
 qtd_ram INT, 
 qtd_disc INT,
 modelo_cpu VARCHAR(45),
 CONSTRAINT pk_servidor_datacenter
	PRIMARY KEY (idServidor, fk_datacenter),
 CONSTRAINT fk_datacenter_registro
	FOREIGN KEY (fk_datacenter)
		REFERENCES Datacenter(idDatacenter)
);

CREATE TABLE Log_medicao (
idMedicao INT AUTO_INCREMENT,
fk_servidor INT, 
cpu_atual DECIMAL(4,2) NOT NULL,
ram_atual DECIMAL(4,2) NOT NULL,
disco_atual DECIMAL(4,2) NOT NULL,
time_log DATETIME DEFAULT CURRENT_TIMESTAMP, 
CONSTRAINT pk_servidor_medicao
	PRIMARY KEY (idMedicao, fk_servidor),
CONSTRAINT fk_servidor_registro
	FOREIGN KEY (fk_servidor)
		REFERENCES Servidor (idServidor)
);


CREATE TABLE Alerta (
idAlerta INT AUTO_INCREMENT,
fk_logmedicao INT, 
data_alerta DATETIME DEFAULT CURRENT_TIMESTAMP, 
criticidade VARCHAR(45), 
CONSTRAINT pk_alerta_logmedicao
	PRIMARY KEY (idAlerta, fk_logmedicao),
CONSTRAINT fk_logmedicao_registro
	FOREIGN KEY (fk_logmedicao)
		REFERENCES Log_medicao (idMedicao)
); 