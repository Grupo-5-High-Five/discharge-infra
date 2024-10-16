CREATE TABLE IF NOT EXISTS leitura (
    id INT NOT NULL AUTO_INCREMENT,
    data VARCHAR(255) NOT NULL,
    consumo DECIMAL(6,3) DEFAULT NULL,
    potenciaReativaAtrasada DECIMAL(6,3) DEFAULT NULL,
    potenciaReativaAdiantada DECIMAL(6,3) DEFAULT NULL,
    emissao DECIMAL(6,3) DEFAULT NULL,
    fatorPotenciaAtrasado DECIMAL(6,3) DEFAULT NULL,
    fatorPotenciaAdiantado DECIMAL(6,3) DEFAULT NULL,
    statusSemana VARCHAR(255) DEFAULT NULL,
    diaSemana VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (id)
);