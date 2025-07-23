# desafio-tecnico

## [DASHBOARD LOOKER STUDIO + ANÁLISE DOS DADOS](https://lookerstudio.google.com/reporting/d2ff49fc-04bb-4f99-be56-8d7448025f1d)

## [ARQUIVO SQL COMPLETO](desafio_tecnico_SQL.sql)

Realizei o tratamento dos dados no SQL, tive dificuldade na importação da base direto pela interface, então utilizei o site: https://www.convertcsv.com/csv-to-sql.htm para fazer via INSERT INTO, consegui realizar dessa forma porém os números decimais do Valor Gasto (investimento) foram carregados em formato Inteiro, então fiz a tratativa dividindo por 100 para manter a integridade com a base original e dados corretos, além disso tratei os dados NULL substituindo por 0 por ser tratarem de métricas então substituir por 0 não afetaria a análise, além disso alguns valores de leads estavam decimais ao invés de inteiros, então ajustei arrendondando para cima, eram valores como 0,5 ou 4,5 então por conta do arredondamento pode ocorrer uma pequena diferença nos dados de vocês e dos meus, mas apenas por questão de critério de arredondamento. Após tratar os dados e resolver no SQL as questões obrigatórias eu exportei os dados tratados para um CSV e partir disso carreguei os dados no Looker para seguir com o Dashboard.

Durante o desafio da API, eu tive dificuldade no retorno dos dados via método GET para o data, não consegui receber os dados, mas expliquei no código também e corrigi manualmente no CSV para fins de organização até por se tratar de poucos dados.

## - Qual Campanha trouxe mais leads no período total
![Pergunta_sql_1](/assets/images/pergunta_1.png)


## - Qual Campanha tem melhor CPL no período total
![Pergunta_sql_2](/assets/images/pergunta_2.png)


## [API REST CLIMA TEMPO]([HP]%20TESTE%20TÉCNICO%20API%20TEMPO%20-%20Rodrigo%20Pereira.ipynb)

## [ARQUIVO CSV GERADO COM OS DADOS API](historico_tempo.csv)
