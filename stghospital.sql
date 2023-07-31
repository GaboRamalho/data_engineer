-- Problema 1
-- Criação dos schemas dos hospitais
CREATE SCHEMA IF NOT EXISTS stg_hospital_a;
CREATE SCHEMA IF NOT EXISTS stg_hospital_b;
CREATE SCHEMA IF NOT EXISTS stg_hospital_c;

-- Criação da tabela PACIENTE no schema stg_prontuario
CREATE SCHEMA IF NOT EXISTS stg_prontuario;
USE stg_prontuario;

CREATE TABLE PACIENTE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    dt_nascimento DATE,
    cpf BIGINT,
    nome_mae VARCHAR(100),
    dt_atualizacao TIMESTAMP
);

-- Inserção de dados fictícios na tabela PACIENTE do schema stg_prontuario
INSERT INTO PACIENTE (nome, dt_nascimento, cpf, nome_mae, dt_atualizacao)
VALUES
    ('João da Silva', '1990-05-15', 12345678901, 'Maria da Silva', '2023-07-27 10:00:00'),
    ('Maria Oliveira', '1985-09-22', 98765432109, 'Ana Oliveira', '2023-07-27 11:30:00'),
    ('Carlos Santos', '1982-11-10', 65432198709, 'Rosa Santos', '2023-07-27 09:15:00'),
    ('Fernanda Almeida', '1978-04-03', 45678912309, 'Sandra Almeida', '2023-07-27 14:20:00'),
    ('José Pereira', '1973-12-28', 78901234509, 'Isabel Pereira', '2023-07-27 16:45:00'),
    ('Luisa Souza', '1998-07-19', 56789012309, 'Marta Souza', '2023-07-27 13:10:00');

select * from PACIENTE;

-- Problema 2
-- Criação da tabela PACIENTE no schema stg_hospital_a
USE stg_hospital_a;

CREATE TABLE PACIENTE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    dt_nascimento DATE,
    cpf BIGINT,
    nome_mae VARCHAR(100),
    dt_atualizacao TIMESTAMP
);

-- Inserção de dados fictícios na tabela PACIENTE do schema stg_hospital_a
INSERT INTO PACIENTE (nome, dt_nascimento, cpf, nome_mae, dt_atualizacao)
VALUES
    -- dados aleatórios do hospital A
    ('João do Hospital A', '1995-03-12', 11111111111, 'Maria do Hospital A', '2023-07-27 08:00:00'),
    ('Maria do Hospital A', '1980-11-25', 22222222222, 'Ana do Hospital A', '2023-07-27 09:30:00');

-- mesmo processo para o hospital B e C
-- Criação da tabela PACIENTE no schema stg_hospital_b
USE stg_hospital_b;

CREATE TABLE PACIENTE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    dt_nascimento DATE,
    cpf BIGINT,
    nome_mae VARCHAR(100),
    dt_atualizacao TIMESTAMP
);

-- Inserção de dados fictícios na tabela PACIENTE do schema stg_hospital_b
INSERT INTO PACIENTE (nome, dt_nascimento, cpf, nome_mae, dt_atualizacao)
VALUES
    -- dados do hospital B
    ('Pedro do Hospital B', '1987-08-18', 33333333333, 'Laura do Hospital B', '2023-07-27 10:45:00'),
    ('Ana do Hospital B', '1992-06-29', 44444444444, 'Sandra do Hospital B', '2023-07-27 11:15:00');

-- Criação da tabela PACIENTE no schema stg_hospital_c
USE stg_hospital_c;

CREATE TABLE PACIENTE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    dt_nascimento DATE,
    cpf BIGINT,
    nome_mae VARCHAR(100),
    dt_atualizacao TIMESTAMP
);

-- Inserção de dados fictícios na tabela PACIENTE do schema stg_hospital_c
INSERT INTO PACIENTE (nome, dt_nascimento, cpf, nome_mae, dt_atualizacao)
VALUES
    -- dados do hospital C
    ('Lucas do Hospital C', '1975-02-05', 55555555555, 'Paula do Hospital C', '2023-07-27 12:30:00'),
    ('Mariana do Hospital C', '2000-09-14', 66666666666, 'Isabela do Hospital C', '2023-07-27 13:00:00');



-- Copiar dados do hospital A para a tabela PACIENTE no schema stg_prontuario
INSERT INTO stg_prontuario.PACIENTE (nome, dt_nascimento, cpf, nome_mae, dt_atualizacao)
SELECT nome, dt_nascimento, cpf, nome_mae, dt_atualizacao
FROM stg_hospital_a.PACIENTE;

-- Copiar dados do hospital B para a tabela PACIENTE no schema stg_prontuario
INSERT INTO stg_prontuario.PACIENTE (nome, dt_nascimento, cpf, nome_mae, dt_atualizacao)
SELECT nome, dt_nascimento, cpf, nome_mae, dt_atualizacao
FROM stg_hospital_b.PACIENTE;

-- Copiar dados do hospital C para a tabela PACIENTE no schema stg_prontuario
INSERT INTO stg_prontuario.PACIENTE (nome, dt_nascimento, cpf, nome_mae, dt_atualizacao)
SELECT nome, dt_nascimento, cpf, nome_mae, dt_atualizacao
FROM stg_hospital_c.PACIENTE;

-- Problema 3
SELECT nome, dt_nascimento, cpf, nome_mae, COUNT(*) AS quantidade_duplicados
FROM stg_prontuario.PACIENTE
GROUP BY nome, dt_nascimento, cpf, nome_mae
HAVING COUNT(*) > 1;

-- Problema 4
WITH PacientesDuplicados AS (
    SELECT 
        nome,
        dt_nascimento,
        cpf,
        nome_mae,
        dt_atualizacao,
        ROW_NUMBER() OVER (PARTITION BY nome, dt_nascimento, cpf, nome_mae ORDER BY dt_atualizacao DESC) AS rn
    FROM stg_prontuario.PACIENTE
)
SELECT 
    nome,
    dt_nascimento,
    cpf,
    nome_mae,
    dt_atualizacao
FROM PacientesDuplicados
WHERE rn = 1;
