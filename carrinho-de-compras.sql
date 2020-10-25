/* REQUISITOS */

-- 1 - SE O CLIENTE NÃO POSSUIR UM CARRINHO DE COMPRAS O CARRINHO DEVERÁ SER CRIADO
-- 2 - ANTES DE ADICIOANR UM PRODUTO AO CARRINHO DEVE-SE OBSERVAR SE HÁ ESTOQUE 
--      PARA QUE AQUELE PRODUTO POSSA SER ADICIONADO AO CARRINHO
-- 3 - DEVE-SE VERIFICAR SE O PRODUTO JÁ ESTÁ NO CARRINHO E SE ESTIVER O 
--      PRODUTO DEVE SER INCREMENTADO A QUANTIDADE DO CARRINHO 

/* FUNÇÕES NECESSAŔIAS PARA A RESOLUÇÃO */

-- ADICIONAR_PRODUTO_AO_CARRINHO(PRODUTO_LOJA_ID INT, CLIENT_ID INT, QTD INT)       -> VOID (ESTA É A FUNÇÃO PRINCIPAL DO ARQUIVO, AS OUTRAS SÃO AUXILIARES)
-- RECUPERAR_ID_ITEM_CARRINHO(PRODUTO_LOJA_ID INT, CARRINHO_ID INT)                 -> INT
-- PRODUTO_JA_NO_CARRINHO(CARRINHO_ID INT, PRODUTO_LOJA_ID INT, QTD INT)            -> BOOLEAN
-- RECUPERAR_CARRINHO_DO_USUÁRIO(CLIENT_ID INT)                                     -> INT
-- CRIAR_NOVO_CARRINHO(CLIENT_ID INT)                                               -> INT
-- VERIFICAR_ESTOQUE_DO_PRODUTO(PRODUTO_LOJA_ID INT, QTD INT)                       -> BOOLEAN

--===========================================================================================--
CREATE OR REPLACE FUNCTION ADICIONAR_PRODUTO_AO_CARRINHO(PRODUTO_LOJA_ID INT, CLIENT_ID INT, QTD INT)
RETURNS VOID AS $$
DECLARE
    CARRINHO_ID INT;
    HA_ESTOQUE BOOLEAN;
    ITEM_CARRINHO_ID INT;
BEGIN

    CARRINHO_ID := (RECUPERAR_CARRINHO_DO_USUÁRIO(CLIENT_ID));
    HA_ESTOQUE := (VERIFICAR_ESTOQUE_DO_PRODUTO(PRODUTO_LOJA_ID, QTD));

    IF (HA_ESTOQUE = FALSE) THEN
        RAISE EXCEPTION 'QUANTIDADE INFORMADA NÃO DISPONÍVEL EM ESTOQUE';
    ELSIF (PRODUTO_JA_NO_CARRINHO(CARRINHO_ID, PRODUTO_LOJA_ID, QTD) = TRUE) THEN
        ITEM_CARRINHO_ID = (RECUPERAR_ID_ITEM_CARRINHO(PRODUTO_LOJA_ID, CARRINHO_ID));

        UPDATE ITEM_CARRINHO
        SET QUANTIDADE = QUANTIDADE + QTD
        WHERE ID_ITEM_CARRINHO = ITEM_CARRINHO_ID;
        RAISE INFO 'PRODUTO ADICIONADO AO CARRINHO (ADICIONADO A QUANTIDADE JÁ EXISTENTE)';
    ELSE
        INSERT INTO ITEM_CARRINHO (ID_PRODUTO_LOJA, ID_CARRINHO, QUANTIDADE)
        VALUES (PRODUTO_LOJA_ID, CARRINHO_ID, QTD);
        RAISE INFO 'PRODUTO ADICIONADO AO CARRINHO';
    END IF;
    
END;
$$ LANGUAGE PLPGSQL;

--===========================================================================================--
CREATE OR REPLACE FUNCTION RECUPERAR_ID_ITEM_CARRINHO(PRODUTO_LOJA_ID INT, CARRINHO_ID INT) 
RETURNS INT AS $$
DECLARE
    ITEM_CARRINHO_ID INT;
BEGIN

    SELECT ID_ITEM_CARRINHO FROM ITEM_CARRINHO 
    WHERE ID_PRODUTO_LOJA = PRODUTO_LOJA_ID AND ID_CARRINHO = CARRINHO_ID
    INTO ITEM_CARRINHO;

    RETURN ITEM_CARRINHO_ID;

END;
$$ LANGUAGE PLPGSQL;

--===========================================================================================--
CREATE OR REPLACE FUNCTION PRODUTO_JA_NO_CARRINHO(CARRINHO_ID INT, PRODUTO_LOJA_ID INT, QTD INT)
RETURNS BOOLEAN AS $$
DECLARE
    PRODUTO_ESTA_NO_CARRINHO BOOLEAN;
    QTD_MAIS_QTD_CARRINHO INT;
    HA_ESTOQUE BOOLEAN;
BEGIN

    SELECT COUNT(ID_ITEM_CARRINHO) > 0 FROM ITEM_CARRINHO 
    WHERE ID_PRODUTO_LOJA = PRODUTO_LOJA_ID AND ID_CARRINHO = CARRINHO_ID 
    INTO PRODUTO_ESTA_NO_CARRINHO;

    IF (PRODUTO_ESTA_NO_CARRINHO = TRUE) THEN
        SELECT QUANTIDADE FROM ITEM_CARRINHO 
        WHERE ID_PRODUTO_LOJA = PRODUTO_LOJA_ID AND ID_CARRINHO = CARRINHO_ID 
        INTO QTD_MAIS_QTD_CARRINHO;

        QTD_MAIS_QTD_CARRINHO := QTD_MAIS_QTD_CARRINHO + QTD;
        HA_ESTOQUE := VERIFICAR_ESTOQUE_DO_PRODUTO(PRODUTO_LOJA_ID, QTD_MAIS_QTD_CARRINHO);

        IF (HA_ESTOQUE = TRUE) THEN 
            RETURN TRUE;
        ELSE
            RAISE EXCEPTION 'IMPOSSÍVEL ADICIONAR AO CARRINHO, O PRODUTO JÁ ESTÁ NO CARRINHO'
                            'E A QUANTIDADE INFORMADA SOMADA À QUANTIDADE DO CARRINHO É MAIOR'
                            'A QUANTIDADE DISPONÍVEL EM ESTOQUE';
        END IF;
    ELSE
        RETURN FALSE;
    END IF;

END;
$$ LANGUAGE PLPGSQL;

--===========================================================================================--
CREATE OR REPLACE FUNCTION RECUPERAR_CARRINHO_DO_USUÁRIO(CLIENT_ID INT)
RETURNS INT AS $$
DECLARE
    CARRINHO_ENCONTRADO INT;
    CARRINHO_ID INT;
BEGIN

    SELECT COUNT(ID_CARRINHO) FROM CARRINHO 
    WHERE ID_CLIENTE = CLIENT_ID 
    INTO CARRINHO_ENCONTRADO;

    IF (CARRINHO_ENCONTRADO = 1) THEN
        SELECT ID_CARRINHO FROM CARRINHO 
        WHERE ID_CLIENTE = CLIENT_ID 
        INTO CARRINHO_ID;
    ELSE
        CARRINHO_ID := (CRIAR_NOVO_CARRINHO(CLIENT_ID));
    END IF;

    RETURN CARRINHO_ID;

END;
$$ LANGUAGE PLPGSQL;

--===========================================================================================--
CREATE OR REPLACE FUNCTION CRIAR_NOVO_CARRINHO(CLIENT_ID INT)
RETURNS INT AS $$
DECLARE
    CARRINHO_ID INT;
BEGIN
    INSERT INTO CARRINHO(ID_CLIENTE)
    VALUES (1) RETURNING ID_CARRINHO INTO CARRINHO_ID;

    RETURN CARRINHO_ID;
END;
$$ LANGUAGE PLPGSQL;

--===========================================================================================--
CREATE OR REPLACE FUNCTION VERIFICAR_ESTOQUE_DO_PRODUTO(PRODUTO_LOJA_ID INT, QTD INT)
RETURNS BOOLEAN AS $$
DECLARE
    HA_ESTOQUE BOOLEAN DEFAULT FALSE;
BEGIN
    SELECT QUANTIDADE >= QTD FROM PRODUTO_LOJA 
    WHERE ID_PRODUTO_LOJA = PRODUTO_LOJA_ID 
    INTO HA_ESTOQUE;

    RETURN HA_ESTOQUE;
END;
$$ LANGUAGE PLPGSQL;
--===========================================================================================--