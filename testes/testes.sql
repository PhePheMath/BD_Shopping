/*
* A SEGUIR, UMA SEQUENCIA DE TESTES PARA VERIFICAR POSSÍVEIS ERROS NA IMPLEMENTAÇAÕ DAS FUNCOES
*/

-- TESTES DA FUNCAO "REGISTRAR_LOJA(USUARIO VARCHAR, SENHA VARCHAR, NOME VARCHAR, DESCRICAO VARCHAR)"
SELECT REGISTRAR_LOJA(); -- ERROR:  function registrar_loja() does not exist
SELECT REGISTRAR_LOJA(''); -- ERROR:  function registrar_loja(unknown) does not exist
SELECT REGISTRAR_LOJA('', ''); -- ERROR:  function registrar_loja(unknown, unknown) does not exist
SELECT REGISTRAR_LOJA('', '', ''); -- ERROR:  function registrar_loja(unknown, unknown, unknown) does not exist
SELECT REGISTRAR_LOJA(NULL, NULL, NULL, NULL); -- ERROR:  O VALOR USUARIO NÃO PODE SER NULO, INFORME O USUARIO
SELECT REGISTRAR_LOJA('USUARIO', NULL, NULL, NULL); -- ERROR:  O VALOR SENHA NÃO PODE SER NULO, INFORME UMA SENHA
SELECT REGISTRAR_LOJA('USUARIO', 'SENHA123', NULL, NULL); -- ERROR:  O VALOR NOME NÃO PODE SER NULO, INFORME O NOME (ARGUMENTO NA POSICAO 2)
SELECT REGISTRAR_LOJA('USUARIO', 'SENHA123', 'NOME', NULL); -- ERROR:  O VALOR DESCRICAO NÃO PODE SER NULO, INFORME UMA DESCRICAO (ARGUMENTO NA POSICAO 3)
SELECT REGISTRAR_LOJA('USUARIO', 'SENHA123', 'NOME', 'DESCRICAO', 'VALOR A MAIS'); -- ERROR:  function registrar_loja(unknown, unknown, unknown, unknown, unknown) does not exist
SELECT REGISTRAR_LOJA('', '', '', ''); -- ERROR:  O VALOR USUÁRIO DEVE TER PELO MENOS 3 CARACTERES
SELECT REGISTRAR_LOJA('USUARIO', '', '', ''); -- ERROR:  A SENHA DEVE TER PELO MENOS 6 CARACTERES
SELECT REGISTRAR_LOJA('USUARIO', 'SENHA123', '', ''); -- ERROR:  O NOME DEVE TER PELO MENOS 3 CARACTERES
-- FUNÇÕES QUE REGISTRARAM OS DADOS
SELECT REGISTRAR_LOJA('USUARIO', 'SENHA123', 'NOME', ''); -- INFO:  LOJA REGISTRADA COM SUCESSO!
SELECT REGISTRAR_LOJA('USUARIO', 'SENHA', 'NOME', 'DESCRICAO'); -- INFO:  LOJA REGISTRADA COM SUCESSO!

-- TESTES DA FUNCAO "CADASTRAR_PRODUTO(NOME VARCHAR, DESCRICAO VARCHAR)"
SELECT CADASTRAR_PRODUTO('')
SELECT CADASTRAR_PRODUTO('', '')
SELECT CADASTRAR_PRODUTO(NULL, NULL)
SELECT CADASTRAR_PRODUTO('ALOEVR', NULL)
SELECT CADASTRAR_PRODUTO('MARACA')
SELECT CADASTRAR_PRODUTO('TECPIX', '')
SELECT CADASTRAR_PRODUTO('OMEGA3', 'TOPTHERM')

-- TESTES DA FUNCAO "REGISTRAR_CLIENTE_COM_ENDERECO(NOME VARCHAR, USUARIO VARCHAR, SENHA VARCHAR, CPF VARCHAR, CEP VARCHAR, RUA VARCHAR, NUMERO INT, COMPLEMENTO VARCHAR, CIDADE VARCHAR, UF VARCHAR)"
SELECT REGISTRAR_CLIENTE_COM_ENDERECO('AYANA MARIA SILCA', 'AYA', 'dJANGO01', '122.001.222-03', 'MAYEVIRA', 'VALADARES', 4550, 'APT 3', 'TERESINA', 'PI')

-- TESTES DA FUNCAO "ADICIONAR_PRODUTO_NA_LOJA(PRODUTO_ID INT, LOJA_ID INT, PRECO FLOAT, QUANTIDADE INT)"
SELECT ADICIONAR_PRODUTO_NA_LOJA(1, 1, 11.90, 5)

-- TESTES DA FUNCAO "ADICIONAR_CARTAO_AO_PERFIL( TITULAR VARCHAR, DIGITOS VARCHAR, VALIDADE VARCHAR, CSV VARCHAR, SAVE BOOLEAN, USUARIO VARCHAR)"
SELECT ADICIONAR_CARTAO_AO_PERFIL('AYANA MARIA SILCA', '013', '12/05', '151', TRUE, 'AYA')

-- TESTES DA FUNCAO "REGISTRAR_ENDERECO_NO_BANCO_DE_DADOS(CEP VARCHAR, RUA VARCHAR, NUMERO INT, COMPLEMENTO VARCHAR, CIDADE VARCHAR, UF VARCHAR)"
SELECT REGISTRAR_ENDERECO_NO_BANCO_DE_DADOS('11111111', 'RUA VARCHAR', '1212', 'AO TOPO DO MORRO', 'DHELY', 'NORTH AFRICA')

-- TESTES DA FUNCAO "CADASTRAR_PRODUTO(NOME VARCHAR, DESCRICAO VARCHAR)"
-- TESTES DA FUNCAO "CADASTRAR_PRODUTO(NOME VARCHAR, DESCRICAO VARCHAR)"
-- TESTES DA FUNCAO "CADASTRAR_PRODUTO(NOME VARCHAR, DESCRICAO VARCHAR)"
-- TESTES DA FUNCAO "CADASTRAR_PRODUTO(NOME VARCHAR, DESCRICAO VARCHAR)"
-- TESTES DA FUNCAO "CADASTRAR_PRODUTO(NOME VARCHAR, DESCRICAO VARCHAR)"

