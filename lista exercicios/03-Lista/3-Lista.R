# Arquivo: 03-lista.R
# Autor(a): seu nome
# Data: dd/mm/aaaa
# Objetivo: Resolução da Lista de Exercícios 3

# Configurações globais --------------------------------------

# Configura o número de dígitos exibidos
options(digits = 5, scipen = 999)

# Carrega os pacotes necessários
library(here)
library(tidyverse)


# Exercicio 1 -------------------------------------------------------------

## a

# define o caminho para o arquivo csv
caminho_receitas <- here("dados/brutos/receitas_trimestres.csv")

# importa os dados e armazena no objeto dados_marketing
dados_receitas <- read_csv(caminho_receitas, show_col_types = FALSE)


## b

# exibe uma visao geral dos dados
glimpse(dados_receitas)


## c 

#Essa estrutura que você apresentou é um exemplo clássico de dados em formato 
#Wide (largo), que costuma dificultar a análise automatizada e a criação de gráficos.

# --- ANÁLISE DA ESTRUTURA DOS DADOS ---
# A tabela está em formato 'Wide' (largo), o que é considerado 'untidy' (desorganizado) para análise por:
#
# 1. Variáveis nas Colunas: Os nomes das colunas (T1, T2, T3, T4) representam valores 
#    de uma variável (ex: 'Trimestre' ou 'Tempo'), e não o nome da variável em si.
# 2. Observações Espalhadas: Uma única observação (as vendas de um produto ao longo do tempo) 
#    está distribuída por várias colunas, em vez de cada linha representar um ponto único no tempo.
# 3. Dificuldade de Escala: Se adicionarmos T5, T6, etc., precisaremos criar novas colunas, 
#    o que quebra cálculos de agregados (médias, somas) e dificulta a plotagem no ggplot2.
#
# O ideal seria transformar para o formato 'Long' (com colunas: Produto, Trimestre, Valor).



## d

# TRANSFORMA RECEITAS PARA O FORMATO LONGO
receitas_longas <- dados_receitas |> 
  pivot_longer(
    cols = c ("T1","T2", "T3", "T4"),
    names_to = "Trimestre",
    values_to = "Receita"
  )

#exibe o resultado
receitas_longas

glimpse(receitas_longas)

## e 
# visualiza o objeto no RStudio
View(receitas_longas)


# Exercício 2 ------------------------------------------------


## a

# define o caminho para o arquivo csv
caminho_desempenho <- here("dados/brutos/desempenho-empresa.csv")

# importa os dados e armazena no objeto dados_marketing
dados_desempenho <- read_csv(caminho_desempenho, show_col_types = FALSE)


## b
# exibe uma visao geral dos dados
glimpse(dados_desempenho)

## c 
# ANÁLISE DOS NOMES DAS COLUNAS ---
  # Os nomes das colunas (ex: receita_T1, despesa_T2) estão "sujos" pois 
  # combinam duas informações distintas em uma única string:
  #
  # 1. Tipo de Métrica: Indica se o valor se refere a 'receita' ou 'despesa'.
  # 2. Período Temporal: Indica a qual trimestre o dado pertence ('T1' ou 'T2').
  #
  # Para uma análise eficiente, essas informações deveriam estar separadas 
  # em duas colunas diferentes (ex: uma coluna 'tipo' e uma coluna 'trimestre').

## d

#transforma desempenha para o formato longo
desempenho_longo <- desempenho |> 
  pivot_longer(
    cols = -empresa,
    names_to = c("indicador", "trimestre"),
    names_sep = "_",
    values_to = "valor"
  )
#exibe o resultado
desempenho_longo

glimpse(receitas_longas)

## e

# visualiza o objeto no RStudio
View(desempenho_longo)


# Exercício 3 ------------------------------------------------


## a

# define o caminho para o arquivo csv
caminho_produtos<- here("dados/brutos/produtos.csv")
caminho_vendas <- here("dados/brutos/vendas.csv")
caminho_clientes <- here("dados/brutos/clientes.csv")

# importa os dados e armazena no objeto dados_marketing
dados_produtos <- read_csv(caminho_produtos, show_col_types = FALSE)
dados_vendas <- read_csv(caminho_vendas, show_col_types = FALSE)
dados_clientes <- read_csv(caminho_clientes, show_col_types = FALSE)



## b
# exibe uma visao geral dos dados
glimpse(dados_produtos)
glimpse(dados_vendas)
glimpse(dados_clientes)

## c

#Use left_join() para combinar dados_vendas com dados_produtos, 
#utilizando a variável codigo_produto. Salve o resultado em um objeto 
#chamado vendas_produtos e visualize esse objeto com glimpse() e, em seguida, com View.

#COMBINA VENDAS E PRODUTOS USANDO LEFT_JOIN()
vendas_produtos <- dados_vendas |> 
  left_join(dados_produtos, by = "codigo_produto")

# exibe a estrutura do objeto
glimpse(vendas_produtos)

# visualiza o objeto no RStudio
View(vendas_produtos)


## d


## e


## f


## g


## h


## i

