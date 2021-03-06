--======================================CLIENTE============================================--
-- REGISTRAR CLIENTE
CREATE OR REPLACE FUNCTION REGISTRAR_CLIENTE_COM_ENDERECO(
	-- Cliente
	NOME VARCHAR,
	USUARIO VARCHAR,
	SENHA VARCHAR,
	CPF VARCHAR,
	-- Endereco
	CEP VARCHAR,
	RUA VARCHAR,
	NUMERO INT,
	COMPLEMENTO VARCHAR,
	CIDADE VARCHAR,
	UF VARCHAR
) RETURNS VOID AS $$
DECLARE
	ID_ENDEREC INT;
BEGIN 
	IF (NOME IS NULL) THEN
		RAISE EXCEPTION 'INFORME O NOME DO CLIENTE';
	ELSIF (USUARIO IS NULL) THEN 
		RAISE EXCEPTION 'INFORME O USUARIO DO CLIENTE';
	ELSIF (SENHA IS NULL) THEN 
		RAISE EXCEPTION 'INFORME A SENHA DO CLIENTE';
	ELSIF (CPF IS NULL) THEN 
		RAISE EXCEPTION 'INFORME O CPF DO CLIENTE';
	ELSIF (CEP IS NULL) THEN 
		RAISE EXCEPTION 'INFORME O CEP DO ENDERECO';
	ELSIF (RUA IS NULL) THEN
		RAISE EXCEPTION 'INFORME A RUA DO ENDERECO';
	ELSIF (NUMERO IS NULL) THEN
		RAISE EXCEPTION 'INFORME O NUMERO DO ENDERECO';
	ELSIF (COMPLEMENTO IS NULL) THEN
		RAISE EXCEPTION 'INFORME O COMPLEMENTO DO ENDERECO';
	ELSIF (CIDADE IS NULL) THEN
		RAISE EXCEPTION 'INFORME A CIDADE DO ENDERECO';
	ELSIF (UF IS NULL) THEN
		RAISE EXCEPTION 'INFORME A UNIDADE FEDERATIVA (UF) DO ENDERECO';
	-- REGRAS DE NEGOCIO 
	ELSIF (LENGTH(CPF) != 11) THEN
		RAISE EXCEPTION 'O CPF DEVE CONTER 11 CARACTERES';
	ELSIF (LENGTH(CEP) != 8) THEN
		RAISE EXCEPTION 'O CEP DEVE CONTER 8 CARACTERES';
	ELSIF (NUMERO < 0) THEN
		RAISE EXCEPTION 'O NUMERO NAO PODE SER NEGATIVO';
	ELSIF (LENGTH(UF) != 2) THEN
		RAISE EXCEPTION 'A UNIDADE FEDERATIVA DEVE CONTER 2 CARACTERES';
	ELSE
		ID_ENDEREC := (REGISTRAR_ENDERECO_NO_BANCO_DE_DADOS(CEP, RUA, NUMERO, COMPLEMENTO, CIDADE, UF));
		PERFORM REGISTRAR_CLIENTE_NO_BANCO_DE_DADOS(NOME, USUARIO, SENHA, CPF, ID_ENDEREC);
		RAISE INFO 'CLIENTE REGISTRADO NO BANCO DE DADOS COM ENDEREÇO';
	END IF;
END;
$$  LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION REGISTRAR_CLIENTE_NO_BANCO_DE_DADOS(
	NOME VARCHAR,
	USUARIO VARCHAR,
	SENHA VARCHAR,
	CPF VARCHAR,
	ID_ENDERECO INT
)
RETURNS VOID AS $$ 
BEGIN
	INSERT INTO CLIENTE(NOME, USUARIO, SENHA, CPF, ID_ENDERECO)
	VALUES (NOME, USUARIO, SENHA, CPF, ID_ENDERECO);
	RAISE INFO 'CLIENTE REGISTRADO COM SUCESSO!';
END 
$$ LANGUAGE PLPGSQL;


-- VERIFICAR CLIENTE
CREATE OR REPLACE FUNCTION VERIFICA_EXISTENCIA_DE_CLIENTE(CLIENTE_ID INT) 
RETURNS BOOLEAN AS $$
DECLARE
    QTD_RESULTADOS INT;
BEGIN

    SELECT COUNT(ID_CLIENTE) FROM CLIENTE 
    WHERE ID_CLIENTE = CLIENTE_ID
    INTO QTD_RESULTADOS;

    RETURN QTD_RESULTADOS > 0;

END;
$$ LANGUAGE PLPGSQL;


-- BUSCAR ID CLIENTE
CREATE OR REPLACE FUNCTION SELECIONAR_ID_CLIENTE_POR_USUARIO(USUARIO_VAR VARCHAR)
RETURNS INT AS $$
DECLARE
	ID_CLIENTE_RETORNO INTEGER;
BEGIN
	ID_CLIENTE_RETORNO = (SELECT ID_CLIENTE FROM CLIENTE WHERE USUARIO = USUARIO_VAR);
	RETURN ID_CLIENTE_RETORNO;
END $$ LANGUAGE PLPGSQL;
