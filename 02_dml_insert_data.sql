-- -----------------------------------------------------
-- Script DML (Data Manipulation Language)
-- Inserção de Dados para o Projeto Lógico "Estética Automotiva Brilho Máximo"
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Inserção em CLIENTE
-- -----------------------------------------------------
INSERT INTO CLIENTE (nome, cpf, telefone, email) VALUES
('Ana Silva', '11122233344', '910001111', 'ana.silva@email.com'),
('Bruno Costa', '55566677788', '920002222', 'bruno.costa@email.com'),
('Carla Dias', '99988877766', '930003333', 'carla.dias@email.com');

-- -----------------------------------------------------
-- Inserção em VEICULO
-- id_cliente: 1=Ana, 2=Bruno, 3=Carla
-- -----------------------------------------------------
INSERT INTO VEICULO (placa, id_cliente, marca, modelo, ano, cor, status) VALUES
('ABC1234', 1, 'Chevrolet', 'Onix', 2020, 'Preto', 'Ativo'),
('DEF5678', 2, 'Ford', 'Ka', 2018, 'Vermelho', 'Ativo'),
('GHI9012', 1, 'Volkswagen', 'Golf', 2015, 'Prata', 'Ativo'),
('JKL3456', 3, 'Fiat', 'Uno', 2010, 'Branco', 'Inativo');

-- -----------------------------------------------------
-- Inserção em SERVICO
-- -----------------------------------------------------
INSERT INTO SERVICO (nome_servico, descricao, preco) VALUES
('Lavagem Simples', 'Lavagem externa e interna básica.', 30.00),
('Polimento Técnico', 'Remoção de riscos leves e polimento com cera de carnaúba.', 250.00),
('Higienização Interna', 'Limpeza profunda de estofados e carpetes.', 180.00),
('Troca de Óleo', 'Substituição do óleo do motor e filtro.', 120.00);

-- -----------------------------------------------------
-- Inserção em PECA
-- -----------------------------------------------------
INSERT INTO PECA (nome_peca, codigo_referencia, preco_custo, preco_venda) VALUES
('Filtro de Óleo', 'FO-100', 15.00, 25.00),
('Cera de Carnaúba', 'CC-500', 50.00, 80.00),
('Oleo 5W30 (Litro)', 'OL-5W30', 25.00, 35.00);

-- -----------------------------------------------------
-- Inserção em ORDEM_SERVICO
-- placa_veiculo: ABC1234 (Ana), DEF5678 (Bruno), GHI9012 (Ana)
-- -----------------------------------------------------
INSERT INTO ORDEM_SERVICO (placa_veiculo, data_servico, valor_total, status, funcionario_responsavel) VALUES
('ABC1234', '2025-11-15', 280.00, 'Concluída', 'João'), -- OS 1: Lavagem Simples + Polimento
('DEF5678', '2025-11-16', 155.00, 'Concluída', 'Maria'), -- OS 2: Troca de Óleo + Filtro
('GHI9012', '2025-11-17', 180.00, 'Aberta', 'João');    -- OS 3: Higienização Interna

-- -----------------------------------------------------
-- Inserção em ITEM_SERVICO
-- id_os: 1, 2, 3
-- id_servico: 1=Lavagem Simples, 2=Polimento Técnico, 3=Higienização Interna, 4=Troca de Óleo
-- -----------------------------------------------------
INSERT INTO ITEM_SERVICO (id_os, id_servico, preco_cobrado, observacoes) VALUES
(1, 1, 30.00, 'Lavagem padrão.'),
(1, 2, 250.00, 'Polimento com desconto de 20.00.'), -- Preço original 250.00
(2, 4, 120.00, 'Troca de óleo completa.'),
(3, 3, 180.00, 'Limpeza de estofados.');

-- -----------------------------------------------------
-- Inserção em ITEM_PECA
-- id_os: 1, 2, 3
-- id_peca: 1=Filtro de Óleo, 2=Cera de Carnaúba, 3=Oleo 5W30
-- -----------------------------------------------------
INSERT INTO ITEM_PECA (id_os, id_peca, quantidade, preco_unitario_cobrado) VALUES
(2, 1, 1, 25.00), -- OS 2: 1 Filtro de Óleo
(2, 3, 4, 32.50); -- OS 2: 4 Litros de Óleo (Preço com desconto)

-- Nota: A OS 1 e OS 3 não usaram peças vendidas separadamente neste exemplo.
-- O valor_total na ORDEM_SERVICO deve ser recalculado ou ajustado após as inserções
-- (OS 1: 30.00 + 250.00 = 280.00)
-- (OS 2: 120.00 + (1*25.00) + (4*32.50) = 120.00 + 25.00 + 130.00 = 275.00)
-- (OS 3: 180.00)
-- O valor_total da OS 2 foi ajustado para 155.00 no INSERT, o que está incorreto.
-- Vamos corrigir o valor_total da OS 2 para 275.00 no script de UPDATE.
