# Arquivo: 02-lista.R
# Autor(a): Tatiane Arantes
# Data: 07/04/26
# Objetivo:
# 1. Resolver os exercícios da lista 2


# Configurações globais ---------------------------------------------------

# Configura o número de dígitos a serem exibidos
options(digits = 5, scipen = 999)

# carrega os pacotes necessários
# Exercicio 1 -------------------------------------------------------------


## a)
library(tidyverse) # Inclui readr, dplyr, ggplot2, etc.
library(here)      # Para gerenciamento de caminhos de arquivos
library(janitor)   # Para limpeza de nomes de colunas (se necessário)


## b)
# A função here() localiza o arquivo a partir da raiz do projeto
dados_marketing <- read_csv(here("dados", "brutos", "dados-marketing.csv"))

## c)# exibe uma visão compacta do objeto
glimpse(dados_marketing)



# Exercicio 2 -------------------------------------------------------------

## a)1. O que cada linha (observação) do arquivo representa?
# Nesta lista, utilizaremos o arquivo dados-marketing.csv,
#que contém dados sintéticos referentes a uma empresa norte-americana não 
#identificada, com informações semanais sobre gastos de marketing e receita de vendas.
#Cada linha do arquivo representa uma semana de observação. Assim, as observações 
#não correspondem a vendas individuais, mas a registros semanais com informações 
#sobre investimentos em diferentes canais de marketing, ocorrência de promoção, 
#atividade concorrente e receita de vendas.

## b)2. Quantas observações e quantas variáveis há no objeto dados_marketing?
# (Preencha com os números exatos que apareceram no seu console)
# Observações: 156 (linhas)
# Variáveis: 9 (colunas)



# Exercicio 3 -------------------------------------------------------------

## a)  Criar o novo objeto dados_marketing_limpos usando clean_names()
dados_marketing_limpos <- clean_names(dados_marketing)


## Escrever e executar names() para verificar os novos nomes
names(dados_marketing_limpos)



# Exercicio 4 -------------------------------------------------------------
#Utilizando o objeto dados_marketing_limpos, use a função select do dplyr para criar um pipeline 
#(sequência de operações) que mostre apenas as seguintes variáveis: data
#mes,gasto_tv,gasto_radio,promocao,receita_vendas

# Criação do pipeline para selecionar as colunas específicas
dados_selecionados <- dados_marketing_limpos %>%
  select(data, mes, gasto_tv, gasto_radio, promocao, receita_vendas)

# Visualizar o resultado
print(dados_selecionados)


# Exercicio 5 -------------------------------------------------------------
#Use mutate() para criar uma nova variável chamada gasto_total no objeto dados_marketing_limpos, 
#correspondente à soma dos gastos com:
#gasto_tv, gasto_radio,gasto_redes_sociais ,gasto_email
#Depois, exiba as colunas data, mes, gasto_total e receita_vendas.
#Em seguida, escreva e execute View(dados_marketing_limpos) para 
#visualizar o objeto com a nova variável criada.

# 1. Criar a nova variável 'gasto_total' usando mutate()
dados_marketing_limpos <- dados_marketing_limpos %>%
  mutate(gasto_total = gasto_tv + gasto_radio + gasto_redes_sociais + gasto_email)

# 2. Exibir as colunas solicitadas
dados_marketing_limpos %>%
  select(data, mes, gasto_total, receita_vendas)

# 3. Visualizar o objeto no RStudio
View(dados_marketing_limpos)


# Exercicio 6 -------------------------------------------------------------

#Use mutate() e ifelse() para criar as seguintes novas variáveis no objeto dados_marketing_limpos:
#status_promocao, com os valores "Com promoção" e "Sem promoção";
#status_concorrencia, com os valores "Com concorrência" e "Sem concorrência".
#Mantenha também as variáveis originais promocao e atividade_concorrente.
#Depois, use View(dados_marketing_limpos) para visualizar a base de dados e 
#verificar se as novas variáveis foram criadas corretamente.


#Criar as novas variáveis e atualizar o objeto

dados_marketing_limpos <- dados_marketing_limpos %>%
  mutate(
    # Cria status_promocao baseado em promocao (assumindo 1=Sim, 0=Não)
    status_promocao = ifelse(promocao == 1, "Com promoção", "Sem promoção"),
    
    # Cria status_concorrencia baseado em atividade_concorrente (assumindo 1=Sim, 0=Não)
    status_concorrencia = ifelse(atividade_concorrente == 1, "Com concorrência", "Sem concorrência")
  )

# 3. Visualizar a base de dados para verificar as novas colunas
View(dados_marketing_limpos)

# Exercicio 7 -------------------------------------------------------------

#Salve o objeto dados_marketing_limpos na pasta dados/limpos do seu projeto 
#usando a função write_rds() do pacote readr.
#Utilize o nome de arquivo dados_marketing_limpos.rds.

#Salvar o objeto na pasta dados/limpos
# Certifique-se de que a pasta 'dados/limpos' existe no diretório do projeto
write_rds(dados_marketing_limpos, "dados/limpos/dados_marketing_limpos.rds")

#Ler o arquivo salvo para verificar
dados_verificacao <- read_rds("dados/limpos/dados_marketing_limpos.rds")

#Visualizar a base de dados e verificar as novas variáveis
glimpse(dados_verificacao) # Mostra estrutura, tipos de dados e novas colunas
head(dados_verificacao)    # Mostra as primeiras 6 linhas

# Exercicio 8 -------------------------------------------------------------
#Usando o objeto dados_marketing_limpos, aplique a função filter() 
#para identificar apenas as semanas que atendem, simultaneamente, às duas condições abaixo:
#houve promoção;
#a receita de vendas foi maior que 1000.
#Mostre no resultado pelo menos as colunas data, mes, receita_vendas e status_promocao.

# Aplicando o filtro com o termo correto encontrado
resultado <- dados_marketing_limpos %>%
  filter(status_promocao == "Com promoção", receita_vendas > 1000) %>%
  select(data, mes, receita_vendas, status_promocao)

# Visualizando o resultado
print(resultado)

# Teste 1: Quantas linhas têm promoção?
dados_marketing_limpos %>% filter(status_promocao == "Com promoção") %>% nrow()

# Teste 2: Quantas linhas têm receita > 1000?
dados_marketing_limpos %>% filter(receita_vendas > 1000) %>% nrow()

unique(dados_marketing_limpos$status_promocao)

# Exercicio 9 -------------------------------------------------------------
#Usando o objeto dados_marketing_limpos, crie um novo objeto chamado resumo_mensal, 
#que deve conter um resumo dos dados agruados por mes com as seguintes estatísticas:
#receita_media: média da variável receita_vendas;
#receita_total: soma da variável receita_vendas;
#gasto_total_medio: média da variável gasto_total;
#semanas_com_promocao: número de semanas com promoção no mês.
#Em seguida, use arrange() para ordenar o objeto resumo_mensal da maior para a menor receita_media.
#Depois: escreva e execute View(resumo_mensal) no RStudio para inspecionar o objeto resumo_mensal;
#escreva, em comentário no script, quais foram os três meses com maior receita média.


#Criar o objeto resumo_mensal
resumo_mensal <- dados_marketing_limpos %>%
  # Agrupar por mês (assumindo que existe uma coluna 'data')
  group_by(mes = floor_date(data, "month")) %>%
  summarise(
    receita_media = mean(receita_vendas, na.rm = TRUE),
    receita_total = sum(receita_vendas, na.rm = TRUE),
    gasto_total_medio = mean(gasto_total, na.rm = TRUE),
    # Conta quantas semanas tiveram promoção (assumindo 1 para sim, 0 para não)
    semanas_com_promocao = sum(promocao, na.rm = TRUE)
  ) %>%
  # Ordenar da maior para a menor receita_media
  arrange(desc(receita_media))

# Visualizar o objeto
View(resumo_mensal)

