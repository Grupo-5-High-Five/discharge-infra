CREATE TABLE IF NOT EXISTS empresa (
idEmpresa 				INT 			AUTO_INCREMENT COMMENT 'Identificador único da empresa', 
nome_fantasia 			VARCHAR(45) 	NOT NULL COMMENT 'Nome fantasia da empresa',
email 					VARCHAR(345) 	NOT NULL UNIQUE COMMENT 'Email da empresa, deve ser único',
telefone 				VARCHAR(15) 	NOT NULL COMMENT 'Telefone de contato da empresa',
cnpj 					CHAR(18) 		NOT NULL UNIQUE COMMENT 'CNPJ da empresa, deve ser único',
cep 					CHAR(9) 		NOT NULL COMMENT 'CEP da empresa',
statusEmpresa		    VARCHAR(7)		DEFAULT 'ativo' COMMENT 'Status da empresa',

PRIMARY KEY PK_idEmpresa (idEmpresa)
) COMMENT 'Tabela que armazena informações de Empresas';

CREATE TABLE IF NOT EXISTS funcionario (
idFuncionario 		INT 	NOT NULL AUTO_INCREMENT COMMENT 'Identificador único do funcionário',
nome 				VARCHAR(50) 	NOT NULL COMMENT 'Nome do funcionário', 
email 				VARCHAR(345) 	NOT NULL UNIQUE COMMENT 'Email do funcionário, deve ser único',
cpf 				CHAR(12) 		NOT NULL UNIQUE COMMENT 'CPF do funcionário, deve ser único',
cargo 				VARCHAR(11) 	NOT NULL DEFAULT "funcionario" COMMENT 'Tipo de funcionário (superior ou funcionario), para permissionamentos',
senha 				VARCHAR(16) 	NOT NULL COMMENT 'Senha do funcionário, com limite de 16 caracteres',
statusFuncionario 	VARCHAR(7)		DEFAULT 'ativo' COMMENT 'Status do funcionário',
fkEmpresa 			INT 			COMMENT 'Chave estrangeira que referencia a empresa à qual o funcionário pertence',

CONSTRAINT chk_cargo CHECK(cargo IN ("gerente", "funcionario")),
PRIMARY KEY PK_idFuncionario (idFuncionario, fkEmpresa),
FOREIGN KEY ForeignKey_fkEmpresa (fkEmpresa) REFERENCES empresa (idEmpresa)
) COMMENT 'Tabela que armazena informações de Funcionários';

CREATE TABLE IF NOT EXISTS leituras(
idLeitura							 INT AUTO_INCREMENT,
dtLeitura							 DATE,
horaLeitura							 TIME,
consumoKwh							 DECIMAL(6,3),
potenciaReativaAtrasadaKvarh		 DECIMAL(6,3),
potenciaReativaAdiantadaKvarh 		 DECIMAL(6,3),
emissaoCo2  						 DECIMAL(6,2),
fatorPotenciaAtrasado				 DECIMAL(6,3),
fatorPotenciaAdiantado				 DECIMAL(6,3),
diaSemana							 VARCHAR(12),
statusSemana						 VARCHAR(7),
fkEmpresa							 INT,

PRIMARY KEY (idLeitura),
FOREIGN KEY ForeignKey_fkEmpresa (fkEmpresa) REFERENCES empresa (idEmpresa)
);

CREATE TABLE IF NOT EXISTS historicoMensagens(
idHistorico			INT AUTO_INCREMENT,
mensagem            VARCHAR(200),
dataHora			DATETIME,
fkEmpresa			INT,

PRIMARY KEY (idHistorico),
FOREIGN KEY ForeignKey_fkEmpresa (fkEmpresa) REFERENCES empresa (idEmpresa)
);

CREATE TABLE IF NOT EXISTS metrica (
idMetricas			INT AUTO_INCREMENT,
energiaMaxima		VARCHAR(45),
co2Maximo			VARCHAR(45),
fkEmpresa			INT,

PRIMARY KEY (idMEtricas),
FOREIGN KEY ForeignKey_fkEmpresa (fkEmpresa) REFERENCES empresa (idEmpresa)
);