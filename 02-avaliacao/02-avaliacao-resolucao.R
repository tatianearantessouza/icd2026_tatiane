# Arquivo: 02-avaliacao-resolucao.R
# Integrante 1: Eunice Oliveira
# Integrante 2: Gislaine Alves
# Integrante 3: Jennifer Xavier
# Integrante 4: Tatiane Arantes
# Data: 09/06/2026
# Objetivo: Resolução da Avaliação 2 — Introdução à Ciência de Dados


# Configurações globais ---------------------------------------
options(digits = 5, scipen = 999)

# Exercício 1 -------------------------------------------------

# a) S: {renovou contrato, não renovou contrato}
#

# b) Um evento é qualquer subconjunto do espaço amostral A={não renovou contrato}
#

# c) P(A) OU P(renovou contrato) / P (N) OU P(não renovou contrato)
#

# d) Não, o resultado não é diretamente numerico, 
#os resultado brutos do experimento "renovou contrato"
#ou "não renovou contrato" são categorias qualitativas 
#não numeros resultantes de uma contagem ou medição


# e) x = 1 para o evento não renovou contrato; x=0 para renovou contrato.
#

# f) Modelo: Bernoulli
#Justificativa: A variável observada é qualitativa binária, 
#possuindo apenas dois resultados possíveis (sucesso ou fracasso) 
#em uma única tentativa.



# Exercício 2 -------------------------------------------------

# a) X pode assumir dois valores
#X = 0 se não utilizar cupom
#X = 12 se usar cupom
#

# b) P(X = 12) = 0,10
#

# c) P (X=0) 1 - 0,10 = 0,90
#

# d)E(X) = X1 * P(X=12) +X2 *P(X=0)
#E(X) 12 * 0,10 + 0 * 0,90
#E(X) = 1,2

# e) O valor de R$ 1,20 é o custo médio por cupom distribuído. 
#Permitindo que a loja preveja o impacto orçamentário total de 
#cupons distribuidos suavizando o imapacto de cada custo gerado pelo cupom.




# Exercício 3 -------------------------------------------------

# Digite e execute o código necessário e escreva a 
# interpretação em comentários.

set.seed(123)

#a)parametros da simulação
lambda <- 10
capacidade <- 13 
#quantidade de valores de X que serão simulados
n_simulacoes <- 1000

#b) Simula 1.000 valores de x
clientes <- rpois(
  n = n_simulacoes,
  lambda = lambda
)
head(clientes)

#c) Média simulada
media_simulada <-mean(clientes)
media_simulada

#d)proporção de simulações acima da capacidade
prob_acima_capacidade <- mean(clientes > capacidade)
prob_acima_capacidade

#e) percentil 95% 
capacidade_95 <- quantile(clientes, 0.95)
capacidade_95

#e) A média simulada ficou proxima de 10 clientes por hora, pelo modelo esperado
#de Poisson (lambda=10)

#A capacidade de 13 clientes foi excedida em cerca de 12,5% 
#dos valores simulados. Portanto, em uma hora de pico sob esse modelo,
#a unidade ficaria acima da capacidade com alguma frequencia.

#O percentil 95 foi igual a 15. Nesta simulaçao, isso indica que uma 
#capaciade de 15 clientes por hora cobriria cerca de 95% das simulações.

## Assim, se a prioridade for reduzir saturação no horário de pico,
# a capacidade atual de 13 clientes por hora parece limitada. Se a unidade
# aceitar alguma espera em parte das horas de pico, essa capacidade ainda
# pode ser defendida, mas com risco operacional visível.