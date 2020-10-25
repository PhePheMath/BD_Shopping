/* REQUISITOS */

-- 1 - Uma função deve ser criada para registrar o produto na entidade produto
-- 2 - A função adicionar produto na loja deve verificar se todos os dados são válidos
-- 3 - O nome do produto deve conter pelo menos 5 caracteres

/* FUNÇÕES NECESSAŔIAS PARA A RESOLUÇÃO */

-- CADASTRAR_PRODUTO(NOME VARCHAR, DESCRICAO VARCHAR) -> VOID

--===========================================================================================--
CREATE OR REPLACE FUNCTION CADASTRAR_PRODUTO(NOME VARCHAR, DESCRICAO VARCHAR)
RETURNS VOID AS $$
BEGIN

    IF (NOME IS NULL) THEN
        RAISE EXCEPTION 'INFORME O NOME DO PRODUTO';
    ELSIF (DESCRICAO IS NULL) THEN
        RAISE EXCEPTION 'INFORME A DESCRIÇÃO DO PRODUTO';
    ELSIF (LENGTH(NOME) < 5) THEN
        RAISE EXCEPTION 'O NOME DO PRODUTO DEVE CONTER PELO MENOS 5 CARACTERES';
    ELSE
        INSERT INTO PRODUTO(NOME, DESCRICAO)
        VALUES (NOME, DESCRICAO);
        RAISE INFO 'PRODUTO CADASTARDO COM SUCESSO';
    END IF;

END;
$$ LANGUAGE PLPGSQL;
