# Experiência Prática III - Criação e Manipulação de Dados com SQL

Este repositório contém os scripts SQL desenvolvidos para a implementação e manipulação de dados do Projeto Lógico da Estética Automotiva "Brilho Máximo".

O projeto segue o modelo relacional normalizado até a Terceira Forma Normal (3FN), garantindo a integridade referencial e a coerência dos dados.

## Estrutura do Projeto

A pasta `sql/` contém os seguintes scripts, que devem ser executados na ordem numérica:

| Ficheiro | Descrição |
| :--- | :--- |
| `01_ddl_create_tables.sql` | Contém os comandos **DDL (Data Definition Language)** para a criação das 7 tabelas do modelo lógico (`CLIENTE`, `VEICULO`, `SERVICO`, `PECA`, `ORDEM_SERVICO`, `ITEM_SERVICO`, `ITEM_PECA`), incluindo chaves primárias, chaves estrangeiras e restrições (`NOT NULL`, `UNIQUE`, `CHECK`). |
| `02_dml_insert_data.sql` | Contém os comandos **DML (Data Manipulation Language)** de `INSERT` para povoar todas as tabelas com dados iniciais coerentes, respeitando a integridade referencial. |
| `03_dml_manipulation.sql` | Contém os comandos **DML** de `SELECT`, `UPDATE` e `DELETE` para manipulação e consulta dos dados, conforme exigido na avaliação. |

## Instruções de Execução

1.  **Configuração do Ambiente:** Utilize um SGBD relacional compatível com a sintaxe SQL padrão (MySQL, PostgreSQL, etc.). Ferramentas como MySQL Workbench ou PGAdmin são recomendadas.
2.  **Criação do Banco de Dados:** Crie um novo esquema/banco de dados (ex: `brilho_maximo`).
3.  **Execução do DDL:** Execute o script `01_ddl_create_tables.sql` para criar a estrutura das tabelas.
4.  **Inserção de Dados:** Execute o script `02_dml_insert_data.sql` para preencher as tabelas com dados de exemplo.
5.  **Manipulação de Dados:** Execute o script `03_dml_manipulation.sql` para testar as consultas, atualizações e eliminações.

## Destaques do Script `03_dml_manipulation.sql`

### Consultas (SELECT)

O script inclui 5 consultas que demonstram o uso de:
*   `JOIN` (para ligar Cliente, Veículo, OS e Serviço)
*   `WHERE` (para filtrar por nome, status ou ID)
*   `ORDER BY` e `LIMIT` (para ordenação e restrição de resultados)
*   `GROUP BY` e `COUNT` (para agregação de dados)

### Atualizações (UPDATE)

O script inclui 3 comandos `UPDATE` com condições:
1.  Correção do `valor_total` e `status` de uma Ordem de Serviço específica.
2.  Aumento percentual do `preco` de serviços, utilizando uma condição `WHERE` para exclusão.
3.  Alteração do `status` de um veículo.

### Eliminações (DELETE)

O script inclui 3 comandos `DELETE` com condições, demonstrando a necessidade de respeitar a integridade referencial:
1.  Eliminação de um registo sem dependências.
2.  Eliminação de um registo após a inserção de um temporário para demonstração.
3.  Eliminação de uma Ordem de Serviço, exigindo a pré-eliminação dos registos dependentes (`ITEM_SERVICO`).
