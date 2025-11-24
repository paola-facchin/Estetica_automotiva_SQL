-- -----------------------------------------------------
-- Script DML (Data Manipulation Language)
-- Consultas (SELECT), Atualizações (UPDATE) e Eliminações (DELETE)
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Consultas (SELECT)
-- -----------------------------------------------------

-- 1. Listar todos os serviços realizados para um cliente específico (Ana Silva),
--    incluindo o veículo e a data do serviço.
SELECT
    C.nome AS Cliente,
    V.placa AS Placa_Veiculo,
    OS.data_servico AS Data_Servico,
    S.nome_servico AS Servico_Realizado,
    ISV.preco_cobrado AS Preco_Cobrado
FROM CLIENTE C
JOIN VEICULO V ON C.id_cliente = V.id_cliente
JOIN ORDEM_SERVICO OS ON V.placa = OS.placa_veiculo
JOIN ITEM_SERVICO ISV ON OS.id_os = ISV.id_os
JOIN SERVICO S ON ISV.id_servico = S.id_servico
WHERE C.nome = 'Ana Silva'
ORDER BY OS.data_servico DESC;

-- 2. Listar todas as peças utilizadas numa Ordem de Serviço específica (OS 2),
--    mostrando o nome da peça, quantidade e preço unitário cobrado.
SELECT
    OS.id_os AS Ordem_Servico,
    P.nome_peca AS Nome_Peca,
    IP.quantidade AS Quantidade,
    IP.preco_unitario_cobrado AS Preco_Unitario
FROM ORDEM_SERVICO OS
JOIN ITEM_PECA IP ON OS.id_os = IP.id_os
JOIN PECA P ON IP.id_peca = P.id_peca
WHERE OS.id_os = 2;

-- 3. Listar todos os clientes e o número de veículos que possuem, ordenado pelo número de veículos.
SELECT
    C.nome AS Cliente,
    COUNT(V.placa) AS Total_Veiculos
FROM CLIENTE C
LEFT JOIN VEICULO V ON C.id_cliente = V.id_cliente
GROUP BY C.nome
ORDER BY Total_Veiculos DESC;

-- 4. Encontrar o serviço mais caro oferecido no catálogo.
SELECT
    nome_servico,
    preco
FROM SERVICO
ORDER BY preco DESC
LIMIT 1;

-- 5. Listar todas as Ordens de Serviço que ainda estão 'Aberta' e o nome do funcionário responsável.
SELECT
    id_os,
    data_servico,
    funcionario_responsavel
FROM ORDEM_SERVICO
WHERE status = 'Aberta'
ORDER BY data_servico ASC;

-- -----------------------------------------------------
-- Atualizações (UPDATE) - 3 Comandos
-- -----------------------------------------------------

-- 1. Corrigir o valor_total da OS 2, que estava incorreto na inserção (deve ser 275.00).
UPDATE ORDEM_SERVICO
SET valor_total = 275.00,
    status = 'Concluída' -- Atualizar o status para Concluída
WHERE id_os = 2;

-- 2. Aumentar o preço padrão de todos os serviços em 10% (exceto o mais caro, Polimento Técnico).
UPDATE SERVICO
SET preco = preco * 1.10
WHERE nome_servico <> 'Polimento Técnico';

-- 3. Marcar o veículo JKL3456 como 'Ativo' novamente, pois o cliente Carla Dias voltou a usá-lo.
UPDATE VEICULO
SET status = 'Ativo',
    updated_at = CURRENT_TIMESTAMP
WHERE placa = 'JKL3456';

-- -----------------------------------------------------
-- Eliminações (DELETE) - 3 Comandos
-- -----------------------------------------------------

-- 1. Eliminar o veículo JKL3456 (que não tem ordens de serviço associadas, facilitando a eliminação).
-- Nota: A eliminação de veículos com OS associadas exigiria a eliminação em cascata ou a eliminação manual das OS primeiro.
DELETE FROM VEICULO
WHERE placa = 'JKL3456' AND status = 'Ativo'; -- Usando a condição de status para demonstrar o uso de WHERE

-- 2. Eliminar um serviço do catálogo que nunca foi utilizado (ex: 'Troca de Óleo' - id 4).
-- Nota: O serviço 4 foi utilizado na OS 2, então não pode ser eliminado devido à chave estrangeira em ITEM_SERVICO.
-- Vamos criar um novo serviço temporário para eliminar.
INSERT INTO SERVICO (nome_servico, descricao, preco) VALUES ('Serviço Temporário', 'A ser eliminado.', 10.00);
DELETE FROM SERVICO
WHERE nome_servico = 'Serviço Temporário';

-- 3. Eliminar a Ordem de Serviço 3 (que está 'Aberta' e não tem peças associadas, mas tem um item de serviço).
-- Para manter a integridade, primeiro eliminamos os itens de serviço/peça associados.
DELETE FROM ITEM_SERVICO WHERE id_os = 3;
DELETE FROM ORDEM_SERVICO
WHERE id_os = 3 AND status = 'Aberta';
