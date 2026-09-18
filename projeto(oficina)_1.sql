-- Script Projeto oficina -- 

  -- drop database oficina;

create database oficina;
use oficina;

-- CLiente

CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45),
    CPF CHAR(11) NOT NULL,
    Telefone VARCHAR(20),
    Email VARCHAR(45),
    CONSTRAINT unique_cpf_client UNIQUE (CPF)
);

-- Veículo

CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    Placa VARCHAR(7),
    Modelo VARCHAR(45),
    Marca VARCHAR(45),
    Ano INT,
    Cliente_idCliente INT,
    CONSTRAINT fk_Veiculo_Cliente
    FOREIGN KEY (Cliente_idCliente)
	REFERENCES Cliente(idCliente)
);

-- Mecânico

CREATE TABLE Mecanico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45),
    Especialidade VARCHAR(45),
    Telefone VARCHAR(20)
);

-- Serviço

CREATE TABLE Servico (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(45),
    ValorMaoDeObra DECIMAL(10,2)
);

-- Peça

CREATE TABLE Peca (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45),
    Fabricante VARCHAR(45),
    ValorUnitario DECIMAL(10,2),
    Estoque INT
);

-- Ordem de Serviço

CREATE TABLE Ordem_Servico (
    idOrdemServico INT AUTO_INCREMENT PRIMARY KEY,
    Numero INT,
    DataEmissao DATE,
    DataConclusao DATE,
    ValorTotal DECIMAL(10,2),
    Status VARCHAR(20),
    Veiculo_idVeiculo INT,
    Mecanico_idMecanico INT,
	CONSTRAINT fk_OrdemServico_Veiculo
	FOREIGN KEY (Veiculo_idVeiculo)
	REFERENCES Veiculo(idVeiculo),
    CONSTRAINT fk_OrdemServico_Mecanico
	FOREIGN KEY (Mecanico_idMecanico)
	REFERENCES Mecanico(idMecanico)
);

CREATE TABLE Servico_has_Ordem_de_Servico (
    Servico_idServico INT,
    Ordem_de_Servico_idOrdemServico INT,
    PRIMARY KEY (Servico_idServico, Ordem_de_Servico_idOrdemServico),
	CONSTRAINT fk_Servico
	FOREIGN KEY (Servico_idServico)
	REFERENCES Servico(idServico),
    CONSTRAINT fk_OrdemServico_Servico
	FOREIGN KEY (Ordem_de_Servico_idOrdemServico)
	REFERENCES Ordem_Servico(idOrdemServico)
);

-- Peça_has_Ordem_de_Servico

CREATE TABLE Peca_has_Ordem_de_Servico (
    Peca_idPeca INT,
    Ordem_de_Servico_idOrdemServico INT,
    PRIMARY KEY (Peca_idPeca, Ordem_de_Servico_idOrdemServico),
    CONSTRAINT fk_Peca
	FOREIGN KEY (Peca_idPeca)
	REFERENCES Peca(idPeca),
	CONSTRAINT fk_OrdemServico_Peca
	FOREIGN KEY (Ordem_de_Servico_idOrdemServico)
	REFERENCES Ordem_Servico(idOrdemServico)
);

CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    TipoPagamento VARCHAR(20),
    Valor DECIMAL(10,2),
    Ordem_de_Servico_idOrdemServico INT,

    CONSTRAINT fk_Pagamento_OrdemServico
        FOREIGN KEY (Ordem_de_Servico_idOrdemServico)
        REFERENCES Ordem_Servico(idOrdemServico)
);

-- Insert CLient

INSERT INTO Cliente (Nome, CPF, Telefone, Email)
VALUES
('João Silva', '12345678901', '(16)99999-0001', 'joao@email.com'),
('Maria Santos', '23456789012', '(16)99999-0002', 'maria@email.com'),
('Carlos Oliveira', '34567890123', '(16)99999-0003', 'carlos@email.com'),
('Ana Souza', '45678901234', '(16)99999-0004', 'ana@email.com'),
('Pedro Costa', '56789012345', '(16)99999-0005', 'pedro@email.com');

-- Insert veiculo

INSERT INTO Veiculo (Placa, Modelo, Marca, Ano, Cliente_idCliente)
VALUES
('ABC1234', 'Civic', 'Honda', 2020, 1),
('DEF5678', 'Corolla', 'Toyota', 2021, 2),
('GHI9012', 'Onix', 'Chevrolet', 2019, 3),
('JKL3456', 'HB20', 'Hyundai', 2022, 4),
('MNO7890', 'Gol', 'Volkswagen', 2018, 5);

-- Insert mecanico

INSERT INTO Mecanico (Nome, Especialidade, Telefone)
VALUES
('Roberto Lima', 'Motor', '16988880001'),
('Marcos Almeida', 'Freios', '16988880002'),
('Fernando Souza', 'Suspensão', '16988880003'),
('Ricardo Santos', 'Elétrica', '16988880004'),
('Paulo Oliveira', 'Injeção Eletrônica', '16988880005');

-- Insert Serviço

INSERT INTO Servico (Descricao, ValorMaoDeObra)
VALUES
('Troca de óleo', 80.00),
('Alinhamento e balanceamento', 120.00),
('Troca de pastilhas de freio', 150.00),
('Revisão de suspensão', 200.00),
('Diagnóstico eletrônico', 100.00);

-- Insert Peça

INSERT INTO Peca (Nome, Fabricante, ValorUnitario, Estoque)
VALUES
('Filtro de óleo', 'Fram', 35.00, 20),
('Pastilha de freio', 'Bosch', 180.00, 15),
('Filtro de ar', 'Mann', 50.00, 12),
('Amortecedor dianteiro', 'Cofap', 350.00, 8),
('Vela de ignição', 'NGK', 45.00, 30);

-- Insert OS

INSERT INTO Ordem_Servico
(Numero, DataEmissao, DataConclusao, ValorTotal, Status, Veiculo_idVeiculo, Mecanico_idMecanico)
VALUES
(1001, '2026-09-01', '2026-09-02', 115.00, 'Concluída', 1, 1),
(1002, '2026-09-03', '2026-09-04', 300.00, 'Concluída', 2, 2),
(1003, '2026-09-05', NULL, 550.00, 'Em andamento', 3, 3),
(1004, '2026-09-06', '2026-09-07', 220.00, 'Concluída', 4, 4),
(1005, '2026-09-08', NULL, 150.00, 'Aberta', 5, 5);

-- Insert das relações serviço com os

INSERT INTO Servico_has_Ordem_de_Servico
(Servico_idServico, Ordem_de_Servico_idOrdemServico)
VALUES
(1, 1),
(2, 1),
(1, 2),
(3, 2),
(3, 3),
(4, 3),
(4, 4),
(2, 4),
(5, 5);

-- Insert das relações serviço com peça

INSERT INTO Peca_has_Ordem_de_Servico
(Peca_idPeca, Ordem_de_Servico_idOrdemServico)
VALUES
(1, 1),
(2, 2),
(3, 2),
(4, 3),
(5, 3),
(1, 4),
(3, 4),
(5, 5);

-- Insert Pagamento

INSERT INTO Pagamento
(TipoPagamento, Valor, Ordem_de_Servico_idOrdemServico)
VALUES
('Pix', 115.00, 1),
('Cartão', 300.00, 2),
('Pix', 550.00, 3),
('Dinheiro', 220.00, 4),
('Cartão', 150.00, 5);



select * from cliente;
select Nome, Telefone from cliente;
show tables; 

Select Count(*)
From Cliente;

Select Count(*)
From veiculo;

Select Count(*)
From mecanico;

select avg(ValorMaoDeObra)
from Servico;

SELECT *
FROM Ordem_Servico
WHERE Status = 'Aberta';

SELECT *
FROM Ordem_Servico
WHERE Status = 'Em andamento';

SELECT *
FROM Ordem_Servico
ORDER BY ValorTotal DESC;

SELECT MAX(ValorMaoDeObra)
FROM Servico;




      

