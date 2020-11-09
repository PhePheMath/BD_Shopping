/* REQUISITOS */
-- 1ª- a função deverá receber o um codigo de tipo de inserção
--  01 - cadastrar cliente
--  02 - cadastrar loja
--  04 - cadastrar produto

-- 2ª- deverá receber os dados da inserção


CREATE OR REPLACE FUNCTION REGISTRAR(
	OPERACAO INT,
     VARCHAR default null,
	 VARCHAR default null,
	 VARCHAR default null,
	 VARCHAR default null,
	 VARCHAR default null,
	 VARCHAR default null,
	 INT default null,
	 VARCHAR default null,
	 VARCHAR default null,
	 VARCHAR default null
) RETURNS VOID AS $$
DECLARE 
BEGIN
    -- cadastrar clientes 
    --(NOME,USUARIO,SENHA,CPF,CEP,RUA,	NUMERO,	COMPLEMENTO,CIDADE,	UF)
    IF OPERACAO = 1 THEN
        PERFORM  REGISTRAR_CLIENTE_COM_ENDERECO($2, $3, $4, $5, $6,$7,$8,$9,$10,$11);
    END IF;
    -- loja
    -- (USUARIO,SENHA,NOME,DESCRICAO,null,null,null,null,null,null)
    IF OPERACAO = 2 THEN
        PERFORM  REGISTRAR_LOJA($2,$3,$4,$5);
    END IF;
    -- produto
    -- (NOME, DESCRICAO)
    IF OPERACAO = 3 THEN
        PERFORM CADASTRAR_PRODUTO($2,$3);
    END IF;
END;
$$  LANGUAGE PLPGSQL;