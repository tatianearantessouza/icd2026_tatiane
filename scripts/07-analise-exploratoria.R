# Arquivo: 07-analise-exploratoria.R
# Autor(a): <seu nome>
# Data: 25/05/2026
# Objetivos:
# 1. Calcular estatísticas descritivas amostrais.
# 2. Visualizar a distribuição empírica dos dados.
# 3. Comparar padrões entre grupos.

# 0. Configurações globais ---------------------------------------------

# Controla a forma como os valores numéricos aparecem no console.
options(digits = 5, scipen = 999)

# Carrega os pacotes usados para caminhos, manipulação e visualização.
library(here)
library(tidyverse)
library(tidyplots)

# Permite que os gráficos do tidyplots usem o espaço disponível.
tidyplots_options(width = NA, height = NA)


# 1. Carregamento dos dados -----------------------------------------------

#Usa um caminho relativo ao projeto para encontrar os dados limpos
caminho_dados <- here("dados/limpos/dados_marketing_limpos.rds")

#Carrega os dados de marketing preparados na lista 2
dados_marketing <- read_rds(caminho_dados)

#Confere variavies, tipos e primeiras obervações dos dados
glimpse(dados_marketing)



# 2. Inspeção Inicial -----------------------------------------------------

#VERIFICA O TAMANHO DOS DADOS: QUANTIDADE DE LINHAS E COLUNAS
dim(dados_marketing)
 
#LISTA OS NOMES DAS VARIAVEIS DISPONIVEIS
names(dados_marketing)

#MOSTRA AS PRIMEIRAS LINHAS PARA UMA INSPEÇÃO RÁPIDA DOS DADOS
head(dados_marketing)

#CONTA QUANTAS SEMANAS APARECEM EM CADA STATUS DE PROMOÇÃO
dados_marketing |> 
  count(status_promocao)


# 3. Primeira estatistica da Receita --------------------------------------

#Calcula estatisticas inicias da receita semanal de vendas
inspecao_receita <- dados_marketing |> 
  summarize(
    n = n(),
    minimo = min(receita_vendas),
    maximo = max(receita_vendas),
    amplitude = max(receita_vendas) - 
      min(receita_vendas)
  )

#mostra a tabela de inspeção no console
inspecao_receita


# 4. DISTRIBUIÇÃO EMPIRICA DA RECEITA -------------------------------------

#VISUALIZA COMO A RECEITA SEMANAL SE DISTRIBUI NOS DADOS OBSERVADOS.
#TIDYPLOT() INICIA O GRÁFICO E ADD_HISTOGRAM() ADICIONA O HISTOGRAMA.
#O ARGUMENTO BINS CONTROLA A QUANTIDADE DE CLASSES DO HISTOGRAMA
dados_marketing |> 
  tidyplot(x = receita_vendas) |> 
  add_histogram(bins = 20)



# 5. Valores tipicos da receita -------------------------------------------

#calcula média e mediana para descrever para descrever o centro da distribuição
centro_receita <- dados_marketing |> 
  summarize(
    media = mean(receita_vendas),
    mediana = median(receita_vendas)
  )
centro_receita