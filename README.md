#  Relatório de funcionários Admitidos no Mês


**Conteúdo:**

  * [1 Descrição](10:3)
  * [2 Script](14:3)
  * [3 Informações complementares](71:3)
  
## 1  Descrição:

Consulta utilizada para trazer os funcionários que foram admitidos no período  selecionado.

## 2 Script

       SELECT pfun.CHAPA,
       pfun.codfuncao                        AS CBO,
       pfun.NOME,
       pfun.dataadmissao                     AS ADMISSAO,
       pfun.DTPRORROGACAOBEM                 AS DT_PRORROG,
       pfun.SALARIO,
       pf.nome                               AS CARGO,
       pse.nrocencustocont                   AS CCUSTO,
       pse.descricao                         AS AREA,
       ppes.dtnascimento                     AS DTNASC,
       ppes.cidade                           AS CID_NASC,
       ppes.estadonatal                      AS UF_SIGLA,
       ppes.rua                              AS ENDERECO,
       ppes.numero                           AS NUMERO,
       ppes.complemento                      AS COMPLEMENTO,
       ppes.bairro                           AS BAIRRO,
       ppes.cep                              AS CEP,
       (SELECT nome
        FROM   pfdepend fd
        WHERE  fd.chapa = TO_CHAR(pfun.chapa)
               AND fd.grauparentesco = '6')  AS NOME_PAI,
       (SELECT nome
        FROM   pfdepend fdm
        WHERE  fdm.chapa = TO_CHAR(pfun.chapa)
               AND fdm.grauparentesco = '7') AS NOME_MAE,
       ppes.cartidentidade                   AS IDENTIDADE,
       ppes.cpf                              AS CPF,
       ppes.carteiratrab                     AS CTPS,
       ppes.seriecarttrab                    AS SERIE,
       ppes.tituloeleitor                    AS TITULO,
       ppes.zonatiteleitor                   AS ZONA,
       ppes.secaotiteleitor                  AS SECAO,
       ppes.certifreserv                     AS RESERVISTA,
       pfun.pispasep                         AS PIS
       FROM   pfunc pfun
       JOIN pfuncao pf
         ON pfun.codfuncao = pf.codigo
       JOIN psecao pse
         ON pfun.codsecao = pse.codigo
       JOIN ppessoa ppes
         ON pfun.codpessoa = ppes.codigo
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
       AND pfun.dataadmissao >= TO_DATE(:dataadmissao, 'dd-mm-yy')

## 3 Informações complementares

No banco utilizado para criar a consulta acima, existem cadastros de funcionários com duas (2) mães no registro de depentende. Por está razão, a subconsulta foi desativada e passamos a utilizaro JOIN para trazer as informações das colunas NOME_MÃE e NOME_PAI.