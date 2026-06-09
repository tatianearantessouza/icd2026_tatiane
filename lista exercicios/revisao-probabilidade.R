# Arquivo: revisao-probabilidade.R
# Autor: TATIANE ARANTES
# Data: 08/06/2026
# Objetivos:
# Exercícios de revisão para a avaliação 2

# Configurações globais -------------------------------------------

# exibe números sem notação científica
options(digits = 5, scipen = 999)


# Pacotes usados ------------------------------------------------------

library(tidyverse)
library(probs) # instale esse pacote

# Orientação:
# Nos Exercícios 1, 2 e 3, escreva as respostas como comentários.
# No Exercício 4, complete e execute o código em R.


# Exercício 1 -----------------------------------------------------
# Experimento, evento e variável aleatória

# a) S: {realizou a compra, não realizou a compra}


# b) Um evento é qualquer subconjunto do espaço amostral A={não realizou a compra}


# c)P(A) OU P(realizou a compra) / P (N) OU P(não realizou a compra)


# d) Não, o resultado não é diretamente numerico, os resultado brutos do experimento "realizou compra"
# ou "não realizou compra" são categorias qualitativas é não numeros resultantes de uma contagem ou medição


# e) x = 1 para o evento realizou a compra; x=0 para não ralizou a compra.


# Exercício 2 -----------------------------------------------------
# Valor esperado em uma decisão simples

# a) Valores possíveis de X: R$ 0 se não houver garantia
#X: R$ 500,00 se a garantia for acionada


# b) P(X = 500.00) = 0,04


# c) P(X = 0) = P(X=0) 1- 0,04 = 0,96.


# d) E(X) = (0 X 0,96) + (500.00 X 0,04)
# E (X) = 0 + 20
# E(X) = 20

# e) Interpretação do valor esperado:
#O valor esperado de R$ 20,00 significa que, em média, 
#a empresa gasta R$ 20,00 com custos de garantia para cada produto vendido.
#Na prática, isso não significa que um único cliente vai 
#custar R$ 20,00 (ou ele custa R$ 0 ou custa R$ 500). 
#Mas, ao vender milhares de produtos, o custo total com reparos 
#dividido pelo total de produtos vendidos vai se aproximar de R$ 20,00 por unidade. 
#Essa informação é vital para a empresa decidir, por exemplo, qual o preço mínimo que 
#ela deve cobrar para vender essa garantia estendida sem ter prejuízo.


# Exercício 3 -----------------------------------------------------
# Escolha de distribuição de probabilidade

# a) Observar se um cliente realizou ou não uma compra após receber uma campanha.
#Modelo: Bernoulli
#Justificativa: A variável observada é qualitativa binária, 
#possuindo apenas dois resultados possíveis (sucesso ou fracasso) em uma única tentativa.


# b) Contar quantos clientes converteram entre 300 clientes contatados.
#Modelo: Binomial
#Justificativa: A variável conta o número total de sucessos (conversões) 
#em um número fixo e conhecido de tentativas independentes ($n = 300$).


# c) Contar quantos clientes chegam a uma unidade de atendimento em uma hora de pico.
#Modelo: Poisson
#Justificativa: A variável é uma contagem de eventos discretos que 
#ocorrem de forma independente ao longo de um intervalo contínuo de tempo determinado (uma hora).


# d) Modelar a variação percentual mensal de um custo em relação ao orçamento, 
#assumindo valores aproximadamente simétricos em torno de uma média.
#Modelo: Normal
#Justificativa: A variável observada é contínua e apresenta uma distribuição 
#simétrica em formato de sino, concentrando a maior frequência de dados ao redor da média.


# Exercício 4 -----------------------------------------------------
# Simulação com distribuição de Poisson
# escreva, complete e execute o código fornecido
#fixa a semente para que a simulação possa ser reproduzida
set.seed(123)

#parametros da simulação
lambda <- 12
capacidade <- 15 
#quantidade de valores de X que serão simulados
n_simulacoes <- 1000

#a) Simula 1.00 valores de x
clientes <- rpois(
  n = n_simulacoes,
  lambda = lambda
)
head(clientes)

#b) Média simulada
media_simulada <-mean(clientes)
media_simulada

#c)proporção de simulações acima da capacidade
prob_acima_capacidade <- mean(clientes > capacidade)
prob_acima_capacidade


#d) percentil 95% 
capacidade_95 <- quantile(clientes, 0.95)
capacidade_95

# e) Interpretação da capacidade atual

# Exercício 4 ------------------------------------------------

# item e) interpretação
# A média simulada ficou próxima de 12 clientes por hora, como esperado
# pelo modelo Poisson(lambda = 12).
#
# A capacidade de 15 clientes foi excedida em cerca de 14,4% dos valores
# simulados. Portanto, em uma hora de pico sob esse modelo, a unidade ficaria
# acima da capacidade com alguma frequência.
#
# O percentil 95 foi igual a 18. Nesta simulação, isso indica que uma
# capacidade de 18 clientes por hora cobriria cerca de 95% das simulações.
#
# Assim, se a prioridade for reduzir saturação no horário de pico,
# a capacidade atual de 15 clientes por hora parece limitada. Se a unidade
# aceitar alguma espera em parte das horas de pico, essa capacidade ainda
# pode ser defendida, mas com risco operacional visível.