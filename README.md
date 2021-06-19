#  Relatório de funcionários Admitidos no Mês


**Conteúdo:**

  * [1 Descrição](https://github.com/vitorroma/Report-SQL/blob/main/README.md#1--descri%C3%A7%C3%A3o)
  * [2 Sistema](https://github.com/vitorroma/Report-SQL/blob/main/README.md#2-sistema)
  * [3 Script](https://github.com/vitorroma/Report-SQL/blob/main/README.md#3-script)
  * [4 Informações complementares](https://github.com/vitorroma/Report-SQL/blob/main/README.md#4-informa%C3%A7%C3%B5es-complementares)
  
## 1  Descrição:

Consulta utilizada para trazer os funcionários que foram admitidos no período selecionado.

## 2 Sistema:

Corpore RM

## 3 Script

       SELECT pfun.CHAPA,
       pfun.codfuncao       AS CBO,
       pfun.NOME,
       pfun.dataadmissao    AS ADMISSAO,
       pfun.fimprazocontr   AS DT_PRORROG,
       pfun.SALARIO,
       pf.nome              AS CARGO,
       pse.nrocencustocont  AS CCUSTO,
       pse.descricao        AS AREA,
       ppes.dtnascimento    AS DTNASC,
       ppes.cidade          AS CID_NASC,
       ppes.estadonatal     AS UF_SIGLA,
       ppes.rua             AS ENDERECO,
       ppes.numero          AS NUMERO,
       ppes.complemento     AS COMPLEMENTO,
       ppes.bairro          AS BAIRRO,
       ppes.naturalidade    AS CIDADE,
       ppes.cep             AS CEP,
       pfdm.nome            AS NOME_MAE,
       pfd.nome             AS NOME_PAI,
       /* 
        
        Essa subconsulta foi desativada e os campos estão sendo entregues via JOIN.
          
       (SELECT max(nome)
         FROM   pfdepend fd
         WHERE  fd.chapa = TO_CHAR(pfun.chapa)
                AND fd.grauparentesco = '6')  AS NOME_PAI,
        (SELECT max(nome)
         FROM   pfdepend fdm
         WHERE  fdm.chapa = TO_CHAR(pfun.chapa)
                AND fdm.grauparentesco = '7') AS NOME_MAE, 
                                                                                   */
       ppes.cartidentidade  AS IDENTIDADE,
       ppes.cpf             AS CPF,
       ppes.carteiratrab    AS CTPS,
       ppes.seriecarttrab   AS SERIE,
       ppes.tituloeleitor   AS TITULO,
       ppes.zonatiteleitor  AS ZONA,
       ppes.secaotiteleitor AS SECAO,
       ppes.certifreserv    AS RESERVISTA,
       pfun.pispasep        AS PIS
FROM   pfunc pfun
       LEFT JOIN pfuncao pf
              ON pfun.codfuncao = pf.codigo
       LEFT JOIN psecao pse
              ON pfun.codsecao = pse.codigo
       LEFT JOIN ppessoa ppes
              ON pfun.codpessoa = ppes.codigo
       LEFT JOIN pfdepend pfd
              ON pfun.chapa = pfd.chapa
                 AND pfd.grauparentesco = '6'
       LEFT JOIN pfdepend pfdm
              ON pfun.chapa = pfdm.chapa
                 AND pfdm.grauparentesco = '7'
WHERE  pfun.CODSITUACAO = 'A'
       AND pfun.CODCOLIGADA = '1'
       AND pfun.CODFUNCAO NOT LIKE 'PEN%'
       AND pfun.CODFUNCAO NOT LIKE 'AUT%'
       AND pf.CODCOLIGADA = '1'
       AND pf.INATIVA = '0'
       AND pse.codcoligada = '1'
       AND pse.codigo LIKE '2.%'
       AND pse.secaodesativada = '0'
       AND ppes.funcionario = '1'
       AND dataadmissao >= TO_DATE(:dataadmissao, 'dd-mm-yy') 

## 4 Informações complementares

No banco utilizado para criar a consulta acima, existem cadastros de funcionários com duas (2) mães no registro de depentende. Por está razão, a subconsulta foi desativada e passamos a utilizaro JOIN para trazer as informações das colunas NOME_MÃE e NOME_PAI. Este foi o metodo adotado para resolver esta situação, no entanto, pode ser usado o MAX na subconsulta para selecionar o dado. 
