CREATE TABLE IF NOT EXISTS LOJA (
	ID_LOJA SERIAL PRIMARY KEY,
	USUARIO VARCHAR(50) NOT NULL,
	SENHA VARCHAR(50) NOT NULL,
	NOME VARCHAR(128) NOT NULL,
	DESCRICAO VARCHAR(500) NOT NULL
);

CREATE TABLE IF NOT EXISTS PRODUTO (
	ID_PRODUTO SERIAL PRIMARY KEY,
	NOME VARCHAR(128) NOT NULL,
	DESCRICAO VARCHAR(500) NOT NULL
);

CREATE TABLE IF NOT EXISTS ENDERECO(
	ID_ENDERECO SERIAL PRIMARY KEY,
	CEP VARCHAR(8) NOT NULL,
	RUA VARCHAR(128) NOT NULL,
	NUMERO INT NOT NULL,
	COMPLEMENTO VARCHAR(128),
	CIDADE VARCHAR(50) NOT NULL,
	UF VARCHAR(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS CLIENTE (
	ID_CLIENTE SERIAL PRIMARY KEY,
	NOME VARCHAR(128),
	USUARIO VARCHAR(50) NOT NULL UNIQUE,
	SENHA VARCHAR(50) NOT NULL,
	CPF VARCHAR(11) UNIQUE NOT NULL,
	ID_ENDERECO INT NOT NULL,
	FOREIGN KEY (ID_ENDERECO) REFERENCES ENDERECO(ID_ENDERECO)
);

CREATE TABLE IF NOT EXISTS CARD (
	ID_CARD SERIAL PRIMARY KEY,
	TITULAR VARCHAR(128) NOT NULL,
	DIGITOS VARCHAR(4) NOT NULL,
	VALIDADE VARCHAR(5) NOT NULL,
	CSV VARCHAR(50) NOT NULL,
	SAVE BOOLEAN,
	ID_CLIENTE INT NOT NULL,
	FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE)
);

CREATE TABLE IF NOT EXISTS PRODUTO_LOJA (
	ID_PRODUTO_LOJA SERIAL PRIMARY KEY,
	ID_PRODUTO INT NOT NULL,
	ID_LOJA INT NOT NULL,
	PRECO_PRODUTO FLOAT NOT NULL,
	QUANTIDADE INT NOT NULL,
	FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO(ID_PRODUTO),
	FOREIGN KEY (ID_LOJA) REFERENCES LOJA(ID_LOJA)
);

CREATE TABLE IF NOT EXISTS CARRINHO (
	ID_CARRINHO SERIAL PRIMARY KEY,
	ID_CLIENTE INT NOT NULL,
	ID_PRODUTO_LOJA INT NOT NULL,
        QUANTIDADE INT NOT NULL DEFAULT 1,
	FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE),
	FOREIGN KEY (ID_PRODUTO_LOJA) REFERENCES PRODUTO_LOJA(ID_PRODUTO_LOJA)
);

CREATE TABLE IF NOT EXISTS PEDIDO (
	ID_PEDIDO SERIAL PRIMARY KEY,
	VALOR FLOAT NOT NULL,
	STATUS_VENDA INT NOT NULL,
	FORMA_DE_PAGAMENTO INT NOT NULL,
	PROTOCOLO_PAGAMENTO VARCHAR(128) NOT NULL,
	DATA_COMPRA DATE NOT NULL,
	DATA_PAGAMENTO DATE,
	DATA_ENVIO DATE,
	DATA_ENTREGA DATE,
	ID_ENDERECO INT NOT NULL,
	ID_CLIENTE INT NOT NULL,
	FOREIGN KEY (ID_ENDERECO) REFERENCES ENDERECO(ID_ENDERECO),
	FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE)
);

CREATE TABLE IF NOT EXISTS ITEM_PEDIDO (
	ID_ITEM_PEDIDO SERIAL PRIMARY KEY,
	ID_PRODUTO_LOJA INT NOT NULL,
	ID_PEDIDO INT NOT NULL,
	VALOR FLOAT NOT NULL,
	FOREIGN KEY (ID_PRODUTO_LOJA) REFERENCES PRODUTO_LOJA(ID_PRODUTO_LOJA),
	FOREIGN KEY (ID_PEDIDO) REFERENCES PEDIDO(ID_PEDIDO)
);
