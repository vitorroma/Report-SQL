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
