-- -----------------------------------------------------
-- Script DDL (Data Definition Language)
-- Criação das Tabelas para o Projeto Lógico "Estética Automotiva Brilho Máximo"
-- -----------------------------------------------------

-- Desativa a verificação de chaves estrangeiras para permitir a criação de tabelas em qualquer ordem
SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------
-- Tabela CLIENTE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS CLIENTE (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf VARCHAR(11) UNIQUE NOT NULL,
  telefone VARCHAR(20),
  email VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- -----------------------------------------------------
-- Tabela VEICULO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS VEICULO (
  placa VARCHAR(7) PRIMARY KEY,
  id_cliente INT NOT NULL,
  marca VARCHAR(50) NOT NULL,
  modelo VARCHAR(50) NOT NULL,
  ano INT,
  cor VARCHAR(20),
  status VARCHAR(10) DEFAULT 'Ativo', -- Ativo/Inativo
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

-- -----------------------------------------------------
-- Tabela SERVICO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS SERVICO (
  id_servico INT AUTO_INCREMENT PRIMARY KEY,
  nome_servico VARCHAR(100) UNIQUE NOT NULL,
  descricao TEXT,
  preco DECIMAL(10,2) NOT NULL CHECK (preco >= 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- -----------------------------------------------------
-- Tabela PECA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PECA (
  id_peca INT AUTO_INCREMENT PRIMARY KEY,
  nome_peca VARCHAR(100) NOT NULL,
  codigo_referencia VARCHAR(50) UNIQUE,
  preco_custo DECIMAL(10,2) CHECK (preco_custo >= 0),
  preco_venda DECIMAL(10,2) NOT NULL CHECK (preco_venda >= 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- -----------------------------------------------------
-- Tabela ORDEM_SERVICO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ORDEM_SERVICO (
  id_os INT AUTO_INCREMENT PRIMARY KEY,
  placa_veiculo VARCHAR(7) NOT NULL,
  data_servico DATE NOT NULL,
  valor_total DECIMAL(10,2) CHECK (valor_total >= 0),
  status VARCHAR(20) NOT NULL DEFAULT 'Aberta', -- Aberta, Em Andamento, Concluída, Cancelada
  funcionario_responsavel VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  FOREIGN KEY (placa_veiculo) REFERENCES VEICULO(placa)
);

-- -----------------------------------------------------
-- Tabela ITEM_SERVICO (Tabela de Ligação N:N)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ITEM_SERVICO (
  id_os INT NOT NULL,
  id_servico INT NOT NULL,
  preco_cobrado DECIMAL(10,2) NOT NULL CHECK (preco_cobrado >= 0),
  observacoes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY (id_os, id_servico),
  FOREIGN KEY (id_os) REFERENCES ORDEM_SERVICO(id_os),
  FOREIGN KEY (id_servico) REFERENCES SERVICO(id_servico)
);

-- -----------------------------------------------------
-- Tabela ITEM_PECA (Tabela de Ligação N:N)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ITEM_PECA (
  id_os INT NOT NULL,
  id_peca INT NOT NULL,
  quantidade INT NOT NULL CHECK (quantidade > 0),
  preco_unitario_cobrado DECIMAL(10,2) NOT NULL CHECK (preco_unitario_cobrado >= 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY (id_os, id_peca),
  FOREIGN KEY (id_os) REFERENCES ORDEM_SERVICO(id_os),
  FOREIGN KEY (id_peca) REFERENCES PECA(id_peca)
);

-- Reativa a verificação de chaves estrangeiras
SET FOREIGN_KEY_CHECKS = 1;
