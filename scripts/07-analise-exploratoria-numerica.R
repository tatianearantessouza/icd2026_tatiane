# Arquivo: 07-analise-exploratoria-numerica.R
# Autor(a): Tatiane Arantes
# Data: 15/06/2026
# Objetivos:
# 1. Carregar e inspecionar os dados de marketing
# 2. Calcular estatísticas amostrais de centro, posição e variabilidade
# 3. Interpretar a receita semanal com base nos dados observados

# 0. Pacotes e opções globais --------------------------------------------

# Opções de exibição numérica
options(digits = 5, scipen = 999)

# Pacotes usados nesta aula
library(here)
library(tidyverse)



# 1. Carregamento dos dados-------------------------------------


# Caminho do arquivo de dados limpos
caminho_dados <- here ("dados/limpos/dados_marketing_limpos.rds")

#leitura dos dados de marketing
dados_marketing  <- read_rds(caminho_dados)

#estrutura dos dados carregados
glimpse(dados_marketing)
                      


# 2. Inspeção inicial --------------------------------------------------------

#Dimensões da base
dim(dados_marketing)

#nomes das variaveis
names(dados_marketing)

#primeiras linhas da base
head (dados_marketing)

#contagem de semanas por status de promoção
dados_marketing |> 
  count(status_promocao)


# 3. Valores tipicos da receita ------------------------------------------

#resumo com medidas amostrais de centro
estatisticas_centro <- dados_marketing |> 
  summarize(
    #media amostral
    media = mean(receita_vendas),
    
    #mediana amostral
    mediana = median(receita_vendas)
  )
  
#exibe o resumo calculado
  estatisticas_centro


# 4. Resumo rápido da receita ---------------------------------------------

#Extrai a coluna receita_vendas com um vetor
  receita <- dados_marketing |> 
    pull(receita_vendas)
  
#resumo amostral basico
  summary (receita)
  

  df <- 
    dados_marketing |> 
    mutate(promocao = factor(status_promocao))
  
  # Para variáveis discretas
  summary(df$promocao)
  

# 5. Quantis da receita ---------------------------------------------------

#quantis amostrais selecionados
quantis_receita <- dados_marketing |>  
  summarize(
    #minimo amostral e percentil 5
    p0 = quantile(receita_vendas, 0),
    p5 = quantile(receita_vendas, 0.05),
    
    #quartis amostrais
    q1 = quantile(receita_vendas, 0.25),
    mediana = quantile(receita_vendas, 0.50),
    q3 = quantile(receita_vendas, 0.75),
  
  #percentil 95 e maximo amostral
  p95 = quantile(receita_vendas, 0.95),
  p100 = quantile(receita_vendas, 1)
  
  )  
  
  #exibe os quantis calculados
  quantis_receita
    
 

  # 6. Variabilidade da receita ---------------------------------------------
  
  #Resumo com medidas amostrais de variabilidade
  estatisticas_variabilidade <- dados_marketing |> 
    summarize(
      #amplitude amostral
      amplitude = max (receita_vendas) - min (receita_vendas),
      
      #variancia amostral
      variancia = var(receita_vendas),
      
      #desvio padrao amostral
      desvio_padrao =sd(receita_vendas),
      
      #intervalo interquartil amostral
      iqr = IQR(receita_vendas)
      
    )
  
  #exibe o resumo calculado
  estatisticas_variabilidade
  
  
  # 7. Coeficiente de variação ----------------------------------------------
  
  #Resumo com média, desvio-padrão e CV amostrais
  cv_receita <- dados_marketing |> 
    summarize(
      #media amostral
      media = mean(receita_vendas),
      
      #desvio-padrão amostral
      desvio_padrao = sd(receita_vendas),
      
      #cv amostral percentual
      cv_percentual = 100 * desvio_padrao / media
    )
  
  #exibe o coeficiente de variação
  cv_receita
    