CREATE SCHEMA desafiofinalsql;
USE desafiofinalsql;

CREATE TABLE Cliente (
    CPF VARCHAR(11) PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Endereco VARCHAR(255) NOT NULL,
    Idade INT NOT NULL,
    Data_cadastro DATE NOT NULL
);

CREATE TABLE Aluguel (
    Codigo_aluguel INT PRIMARY KEY,
    Data_inicio DATE NOT NULL,
    Data_fim DATE NOT NULL,
    Quilometragem_inicial DECIMAL(10, 2) NOT NULL,
    Quilometragem_final DECIMAL(10, 2) NOT NULL,
    Status_aluguel VARCHAR(50) NOT NULL,
    Valor_total DECIMAL(10, 2) NOT NULL,
    fk_Cliente_CPF VARCHAR(11) NOT NULL,
    FOREIGN KEY (fk_Cliente_CPF) REFERENCES Cliente(CPF)
);

CREATE TABLE Pagamento (
    Codigo_pagamento INT PRIMARY KEY,
    Data_pagamento DATE NOT NULL,
    Valor_pago DECIMAL(10, 2) NOT NULL,
    Forma_de_pagamento VARCHAR(50) NOT NULL,
    Tipo_aluguel VARCHAR(50) NOT NULL,
    Seguro_incluso BOOLEAN NOT NULL
);

CREATE TABLE Manutencao (
    Codigo_manutencao INT PRIMARY KEY,
    Data_manutencao DATE NOT NULL,
    Descricao TEXT NOT NULL,
    Valor DECIMAL(10, 2) NOT NULL,
    Tipo_manutencao VARCHAR(100) NOT NULL,
    Responsavel VARCHAR(255) NOT NULL
);

CREATE TABLE Veiculos (
    Placa VARCHAR(7) PRIMARY KEY,
    Status_veiculo VARCHAR(50) NOT NULL,
    Valor_da_diaria DECIMAL(10, 2) NOT NULL,
    Ano INT NOT NULL,
    Marca VARCHAR(100) NOT NULL,
    Modelo VARCHAR(100) NOT NULL,
    Cor VARCHAR(50) NOT NULL
);

CREATE TABLE Realiza (
    fk_Aluguel_Codigo_aluguel INT,
    fk_Pagamento_Codigo_pagamento INT,
    PRIMARY KEY (fk_Aluguel_Codigo_aluguel, fk_Pagamento_Codigo_pagamento),
    FOREIGN KEY (fk_Aluguel_Codigo_aluguel) REFERENCES Aluguel(Codigo_aluguel),
    FOREIGN KEY (fk_Pagamento_Codigo_pagamento) REFERENCES Pagamento(Codigo_pagamento)
);

CREATE TABLE Contem (
    fk_Manutencao_Codigo_manutencao INT,
    fk_Veiculos_Placa VARCHAR(7),
    PRIMARY KEY (fk_Manutencao_Codigo_manutencao, fk_Veiculos_Placa),
    FOREIGN KEY (fk_Manutencao_Codigo_manutencao) REFERENCES Manutencao(Codigo_manutencao),
    FOREIGN KEY (fk_Veiculos_Placa) REFERENCES Veiculos(Placa)
);

CREATE TABLE Compra (
    fk_Pagamento_Codigo_pagamento INT,
    fk_Veiculos_Placa VARCHAR(7),
    PRIMARY KEY (fk_Pagamento_Codigo_pagamento, fk_Veiculos_Placa),
    FOREIGN KEY (fk_Pagamento_Codigo_pagamento) REFERENCES Pagamento(Codigo_pagamento),
    FOREIGN KEY (fk_Veiculos_Placa) REFERENCES Veiculos(Placa)
);
INSERT INTO Cliente (CPF, Nome, Email, Telefone, Endereco, Idade, Data_cadastro) VALUES
('11111111111', 'João Silva', 'joao@email.com', '99999-1111', 'Rua A, 100', 35, '2025-01-10'),
('22222222222', 'Maria Souza', 'maria@email.com', '99999-2222', 'Rua B, 200', 42, '2025-01-15'),
('33333333333', 'Carlos Lima', 'carlos@email.com', '99999-3333', 'Av. C, 300', 28, '2025-02-01'),
('44444444444', 'Ana Pereira', 'ana@email.com', '99999-4444', 'Rua D, 400', 50, '2025-02-20'),
('55555555555', 'Pedro Costa', 'pedro@email.com', '99999-5555', 'Rua E, 500', 25, '2025-03-05'),
('66666666666', 'Juliana Santos', 'juliana@email.com', '99999-6666', 'Av. F, 600', 31, '2025-03-12'),
('77777777777', 'Lucas Ferreira', 'lucas@email.com', '99999-7777', 'Rua G, 700', 45, '2025-04-01'),
('88888888888', 'Fernanda Oliveira', 'fernanda@email.com', '99999-8888', 'Rua H, 800', 29, '2025-04-18'),
('99999999999', 'Rafael Ribeiro', 'rafael@email.com', '99999-9999', 'Av. I, 900', 38, '2025-05-05');

INSERT INTO Aluguel (Codigo_aluguel, Data_inicio, Data_fim, Quilometragem_inicial, Quilometragem_final, Status_aluguel, Valor_total, fk_Cliente_CPF) VALUES
(1, '2025-09-01', '2025-09-05', 1000, 1500, 'Finalizado', 500.00, '11111111111'),
(2, '2025-09-02', '2025-09-08', 2000, 2800, 'Em andamento', 800.00, '22222222222'),
(3, '2025-09-03', '2025-09-10', 300, 700, 'Finalizado', 700.00, '33333333333'),
(4, '2025-09-05', '2025-09-07', 500, 650, 'Finalizado', 300.00, '44444444444'),
(5, '2025-09-06', '2025-09-12', 1200, 1800, 'Em andamento', 600.00, '55555555555'),
(6, '2025-09-07', '2025-09-14', 800, 1400, 'Em andamento', 600.00, '66666666666'),
(7, '2025-09-08', '2025-09-15', 250, 500, 'Finalizado', 250.00, '77777777777'),
(8, '2025-09-09', '2025-09-16', 150, 450, 'Em andamento', 300.00, '88888888888'),
(9, '2025-09-10', '2025-09-17', 100, 500, 'Em andamento', 400.00, '99999999999');

INSERT INTO Pagamento (Codigo_pagamento, Data_pagamento, Valor_pago, Forma_de_pagamento, Tipo_aluguel, Seguro_incluso) VALUES
(1, '2025-09-05', 500.00, 'Cartão', 'Diária', TRUE),
(2, '2025-09-10', 800.00, 'Boleto', 'Mensal', TRUE),
(3, '2025-09-03', 700.00, 'Cartão', 'Diária', TRUE),
(4, '2025-09-07', 300.00, 'Pix', 'Diária', FALSE),
(5, '2025-09-12', 600.00, 'Boleto', 'Mensal', FALSE),
(6, '2025-09-14', 600.00, 'Pix', 'Diária', TRUE),
(7, '2025-09-15', 250.00, 'Cartão', 'Diária', TRUE),
(8, '2025-09-16', 300.00, 'Cartão', 'Diária', FALSE),
(9, '2025-09-17', 400.00, 'Pix', 'Mensal', TRUE);

INSERT INTO Manutencao (Codigo_manutencao, Data_manutencao, Descricao, Valor, Tipo_manutencao, Responsavel) VALUES
(1, '2025-08-30', 'Troca de óleo', 250.00, 'Preventiva', 'Oficina A'),
(2, '2025-09-01', 'Troca de pneus', 800.00, 'Corretiva', 'Oficina B'),
(3, '2025-09-05', 'Revisão geral', 1200.00, 'Preventiva', 'Oficina A'),
(4, '2025-09-10', 'Reparo na embreagem', 500.00, 'Corretiva', 'Oficina C'),
(5, '2025-09-11', 'Troca de filtro', 100.00, 'Preventiva', 'Oficina B'),
(6, '2025-09-12', 'Revisão do motor', 1500.00, 'Preventiva', 'Oficina A'),
(7, '2025-09-13', 'Troca de pastilhas', 300.00, 'Corretiva', 'Oficina C'),
(8, '2025-09-14', 'Conserto de ar-condicionado', 450.00, 'Corretiva', 'Oficina B');

INSERT INTO Veiculos (Placa, Status_veiculo, Valor_da_diaria, Ano, Marca, Modelo, Cor) VALUES
('ABC-123', 'Disponível', 150.00, 2021, 'Ford', 'Ka', 'Branco'),
('DEF-456', 'Alugado', 200.00, 2022, 'Chevrolet', 'Onix', 'Preto'),
('GHI-789', 'Manutenção', 180.00, 2020, 'Volkswagen', 'Gol', 'Vermelho'),
('JKL-012', 'Disponível', 250.00, 2023, 'Hyundai', 'Creta', 'Prata'),
('MNO-345', 'Alugado', 120.00, 2019, 'Fiat', 'Mobi', 'Azul'),
('PQR-678', 'Disponível', 300.00, 2024, 'Toyota', 'Corolla', 'Branco'),
('STU-901', 'Alugado', 220.00, 2023, 'Honda', 'Civic', 'Cinza'),
('VWX-234', 'Disponível', 140.00, 2021, 'Renault', 'Kwid', 'Amarelo'),
('YZA-567', 'Manutenção', 280.00, 2022, 'Jeep', 'Renegade', 'Verde');

SELECT Status_veiculo, COUNT(*) AS TotalVeiculos
FROM Veiculos
GROUP BY Status_veiculo;

SELECT AVG(Valor_total) AS ValorMedioAluguel
FROM Aluguel;

SELECT Tipo_manutencao, SUM(Valor) AS CustoTotal
FROM Manutencao
GROUP BY Tipo_manutencao;

SELECT
    C.Nome AS NomeCliente,
    A.Codigo_aluguel,
    A.Data_inicio,
    A.Valor_total
FROM Cliente AS C
INNER JOIN Aluguel AS A
ON C.CPF = A.fk_Cliente_CPF;

SELECT
    V.Placa,
    V.Marca,
    V.Modelo,
    M.Tipo_manutencao,
    M.Data_manutencao
FROM Veiculos AS V
LEFT JOIN Contem AS C
ON V.Placa = C.fk_Veiculos_Placa
LEFT JOIN Manutencao AS M
ON C.fk_Manutencao_Codigo_manutencao = M.Codigo_manutencao;

UPDATE Veiculos
SET Status_veiculo = 'Manutenção'
WHERE Placa = 'ABC-123';

UPDATE Cliente
SET Endereco = 'Av. Nova, 1234'
WHERE CPF = '11111111111';

SELECT * FROM Cliente;
SELECT * FROM Aluguel;
SELECT * FROM Pagamento;
SELECT * FROM Veiculos;
select * from Manutencao;


