-- Schema da tabela

CREATE TABLE base_hp(
   canal            VARCHAR
  ,campanha         VARCHAR 
  ,grupo_de_anuncio VARCHAR
  ,data             INTEGER  
  ,impressoes       INTEGER 
  ,cliques          INTEGER 
  ,leads            INTEGER 
  ,investimento     INTEGER
);

-- Não estava conseguindo importar a tabela direto no Postgres, então fiz um INSERT INTO com auxílio do site: https://www.convertcsv.com/csv-to-sql.htm
-- O investimento só estava sendo reconhecido como inteiro, então abaixo fiz a query para corrigir e deixar como Decimal da forma correta sem comprometer a integridade dos dados.
ALTER TABLE base_hp 
ALTER COLUMN investimento TYPE DECIMAL(10,2) USING (investimento::DECIMAL / 100);

-- Verificando registros Nulos
SELECT 
    COUNT(*) FILTER (WHERE leads IS NULL) AS leads_nulos,
    COUNT(*) FILTER (WHERE investimento IS NULL) AS valor_gasto_nulos,
	COUNT(*) FILTER (WHERE impressoes IS NULL) AS impressao,
	COUNT(*) FILTER (WHERE cliques IS NULL) AS clique
FROM base_hp;

-- Como se trata de métrica nula, vou substituir por zero para seguir com a análise

UPDATE base_hp
SET leads = 0 
WHERE leads IS NULL;

UPDATE base_hp 
SET investimento = 0 
WHERE investimento IS NULL;

UPDATE base_hp 
SET impressoes = 0 
WHERE impressoes IS NULL;

UPDATE base_hp 
SET cliques = 0 
WHERE cliques IS NULL;

-- As datas estão codificadas então vou decodificar para as datas no formato correto.

-- Converter para data normal
SELECT 
    data AS numero_serial,
    (DATE '1899-12-30' + data * INTERVAL '1 day') AS data_convertida
FROM base_hp;

-- Atualizando a tabela, adicionando uma coluna de data correta
ALTER TABLE base_hp ADD COLUMN data_normal DATE;
UPDATE base_hp
SET data_normal = (DATE '1899-12-30' + data * INTERVAL '1 day');

-- Verificando resultados
SELECT data, data_normal FROM base_hp LIMIT 10;

-- Agora posso responder as perguntas e seguir com a análise:

-- Qual Campanha trouxe mais leads no período total?

SELECT
campanha,
SUM(leads) as total_leads
FROM base_hp
GROUP BY campanha
LIMIT 1;

-- Qual Campanha tem melhor CPL no período total

WITH cpl_por_campanha AS (
    SELECT 
        campanha,
        SUM(investimento) / NULLIF(SUM(leads), 0) AS cpl
    FROM base_hp
    GROUP BY campanha
)
SELECT 
    campanha,
    ROUND(cpl, 2) as melhor_cpl
FROM cpl_por_campanha
WHERE cpl IS NOT NULL
ORDER BY cpl ASC
LIMIT 1;