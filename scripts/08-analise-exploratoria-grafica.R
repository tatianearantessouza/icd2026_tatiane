# Arquivo: 08-analise-exploratoria-grafica.R
# Autor(a): <Tatiane Arantes>
# Data: 22/06/2026
# Objetivos:
# 1. Criar histograma da receita semanal de vendas com tidyplots
# 2. Criar boxplot da receita semanal de vendas com tidyplots
# 3. Criar boxplot comparativo da receita semanal de vendas com tidyplots
#    entre semanas com e sem promoção

# 0. Pacotes e opções globais --------------------------------------------

# Opções de exibição numérica
options(digits = 5, scipen = 999)

# Pacotes usados nesta aula
library(here)
library(tidyverse)
library(tidyplots) 

tidyplots_options(width = NA, height = NA)

# IMPORTAÇÃO DOS DADOS ----------------------------------------------------

#Caminho do arquivo de dados limpos
caminho_dados <- here("dados/limpos/dados_marketing_limpos.rds")

#Leitura dos dados de marketing
dados_marketing <- read_rds (caminho_dados)

#Estrutura dos dados carregados
glimpse (dados_marketing)


# 1. HISTOGRAMA DA RECEITA ------------------------------------------------

#Gera o histograma da receita semanal
dados_marketing |> 
  tidyplot(x = receita_vendas) |> 
  add_histogram(bins = 9)



# 2. ESTATISTICAS DE APOIO PARA INTERPRETAR O HISTOGRAMA ------------------


# Resume o centro da receita semanal.
# Servem só para apoiar a leitura do gráfico, não para substituí-la.
resumo_histograma <- dados_marketing |>
  summarize(
    media = mean(receita_vendas),
    mediana = median(receita_vendas)
  )

# Exibe o resumo calculado.
resumo_histograma


# #CALCULA O TAMANHO DA AMOSTRA -------------------------------------------
n <- length(dados_marketing$receita_vendas)
n


# CALCULA O NÚMERO DE BINS PELA REGRA DE STURGES -------------------------
k <-ceiling(1 + log2(n))
k



# 3. HISTOGRAMA PAR A PUBLICAÇÃO -------------------------------------------

#VERSÃO FINAL: EIXOS NOMEADOS, FONTE DOS DADOS E FONTE AMPLIADA

dados_marketing |> 
  tidyplot(x = receita_vendas) |> 
  add_histogram(bins = 9, fill = "steelblue") |> 
  adjust_x_axis_title("Receita semanal de vendas (em UR$ mil") |> 
  adjust_y_axis_title("Numero de semanas") |> 
  add_caption("Fonte: dados simulados pelo professor.") |> 
  adjust_font(fontsize = 14)
  
  

# 4. BOXPLOT DA RECEITA ---------------------------------------------------

dados_marketing |> 
  tidyplot(y = receita_vendas) |> 
  add_boxplot()
  


# 5. ESTATISTICAS POR STATUS DE PROMOÇÃO ----------------------------------

#Compara semanas com e sem promoção; isto não estima efeito causal
estatisticas_comparativas <- dados_marketing |> 
  group_by (status_promocao) |> 
  summarise(
    n = n(),
    media = mean(receita_vendas),
    mediana = median(receita_vendas),
    cv = sd(receita_vendas) / mean(receita_vendas) * 100
    )

#Exibe o resumo calculado
estatisticas_comparativas


# 6. BOXPLOT COMPARATIVO POR STATUS DE PROMOÇÃO ---------------------------

#compara a receita semanal entre semanas com e sem promoção
dados_marketing |> 
  tidyplot(x = status_promocao, y = receita_vendas) |> 
  add_boxplot()
