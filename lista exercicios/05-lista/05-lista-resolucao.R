# Arquivo: 05-lista-resolucao.R
# Autor(a): Tatiane Arantes
# Data: 25/05/26
# Objetivo: Resolução da Lista de Exercícios 5

# Configurações globais --------------------------------------

options(digits = 5, scipen = 999)

# carrega os pacotes usados
library(tidyverse)

#EXERCICIO1-------------------------------------------------- 
#Campanha de e-mail marketing

#Parametros de modelo:
#n_email é a quantidade de contatos realizados em cada semana.
#rpob_conversão é a taxa historica usada como estimava de p.
#n_semanas é a quantidade de semanas plausiveis simuladas no computador
n_emails <- 600
prob_conversao <- 0.07
n_semanas <- 5000

#Item a) Simule  5.000 semanas de campanha

#Fixa a semente para que a simulação posssa ser reproduzida

set.seed (123)

#Simula a quantidade de conversões em cada semana plausivel.
#Cada valor do vetor conversões representa  um semana simulada da campanha.
conversoes <- rbinom(
  n = n_semanas,
  size = n_emails,
  prob = prob_conversao
)

#Mostra os dez primeiros valores simulados 
head(conversoes,10)


#ITEM B) MEDIA, DESVIO-PADRÃO E QUANTIS 5% E 95%------

#Centro da distribuição: média de conversões por semana
media_conversoes <- mean(conversoes)
media_conversoes

#Oscilação tipica em torno da média: o desvio-padrão descreve
#o quanto as semanas costumam variar.
dp_conversoes <- sd(conversoes)
dp_conversoes

#Quantis 5% e 95%: faixa central de aproximadamente 90% das semanas
faixa_central_conversoes <- quantile(conversoes, c(0.05, 0.95))
faixa_central_conversoes

#ITEM C) PROPORÇÃO DE SEMANAS COM MENOS DE 35 CONVERSÕES ---
#PROPORÇÃO DE SEMANAS COM MENOS DE 35 CONVERSÕES
# A EXPRESSÃO CONVERSÕES < LIMITE RETORNA TRUE/FALSE
# MEAN () CALCULA A PROPORÇÃO
prob_baixo_desempenho <- mean(conversoes <35)
prob_baixo_desempenho


#ITEM D) PROPORÇÃO DE SEMANAS COM 55 CONVERSÕES OU MAIS
prob_alto_desempenho <- mean(conversoes >=55)
prob_alto_desempenho

#E)Com base nos resultados simulados, uma semana com menos de 35 conversões 
#deveria ser interpretada como variação plausível do processo ou como sinal 
#forte de problema? Justifique em um comentário no script.
#Com o parametros usados, a média simulada fica próxima de 42 conversões
#por semana, que é o valor esperado teorico 600*(0.07).
#Na simulação, uma semana com menos de 35 conversões ocorre em cerca de 12% 
#das semanas. Portato, uma unica semana abaixo desse limite ainda parece uma 
#variação plausivel do processo, não um sinal forte de problema por si só.
#Semanas com 55 conversões ou mais são menos frequentes (cerca de 3%), mas
#tambem podem ocrrer dentro da variabilidade esperada.
#O resultado ficaria mais preocupante se o baixo desempenho se repetisse por
#várias semanas ou viesse acompanhado de evidencias externas.



# Exercício 2 ------------------------------------------------
# Atendimento em hora de pico

# Parâmetros do modelo:
# lambda é o número médio de clientes por hora de pico.
# capacidade é o número de clientes que a unidade consegue atender por hora.
# n_horas é o número de horas de pico simuladas. 
#Simule 10.000 meses
lambda <- 18
capacidade <- 22
n_horas <- 10000

# Fixa a semente para que a simulação possa ser reproduzida.
set.seed(456)

# Simula o número de clientes em cada hora de pico.
# Cada valor do vetor clientes representa uma hora simulada.
clientes <- rpois(
  n = n_horas,
  lambda = lambda
)

#Mostra os 10 primeiros valores simulados
head(clientes,10)

#b. Calcule a média e o desvio-padrão simulados
# Média e variância simuladas.
# Na distribuição de Poisson, média e variância teóricas são iguais a lambda.
media_clientes <-mean(clientes)
media_clientes

variancia_clientes <- var(clientes)
variancia_clientes

desvio_padrao_clientes <- sd(clientes)
desvio_padrao_clientes


#c. Calcule a proporção de horas em que a capacidade atual é excedida
prob_saturacao_atual <- mean(clientes > capacidade)
prob_saturacao_atual

# Capacidade que cobre aproximadamente 95% das horas simuladas.
capacidade_95 <- quantile(clientes, 0.95)
capacidade_95

# Observação:
# se o quantil não for inteiro, a capacidade operacional deve ser
# arredondada para cima, pois não é possível atender uma fração de cliente.


#e. Calcule o número médio de clientes acima da capacidade atual, 
#considerando todas as horas simuladas
# Clientes excedentes médios por hora.
# if_else() calcula o excedente quando há saturação e zero caso contrário.
excedente_medio_atual <- mean(
  if_else(clientes > capacidade, clientes - capacidade, 0)
)

# exibe o resultado
excedente_medio_atual


#F. Compare as capacidades de 20, 22 e 25 clientes por hora, 
#calculando para cada uma a proporção de saturação, 
#o excedente médio e a ociosidade média.

# Comparação de políticas de capacidade.
capacidades <- c(20, 22, 25)

# Proporção de horas em que cada capacidade fica saturada.
prob_saturacao <- c(
  mean(clientes > 20),
  mean(clientes > 22),
  mean(clientes > 25)
)

# Clientes acima da capacidade, considerando todas as horas simuladas.
excedente_medio <- c(
  mean(if_else(clientes > 20, clientes - 20, 0)),
  mean(if_else(clientes > 22, clientes - 22, 0)),
  mean(if_else(clientes > 25, clientes - 25, 0))
)

# Capacidade ociosa, considerando todas as horas simuladas.
ociosidade_media <- c(
  mean(if_else(clientes < 20, 20 - clientes, 0)),
  mean(if_else(clientes < 22, 22 - clientes, 0)),
  mean(if_else(clientes < 25, 25 - clientes, 0))
)

# Organiza os resultados em uma tabela.
politicas_capacidade <- tibble(
  capacidade = capacidades,
  prob_saturacao = prob_saturacao,
  excedente_medio = excedente_medio,
  ociosidade_media = ociosidade_media
)

# exibe o resultado
politicas_capacidade

# Interpretação:
#g. Considerando saturação e ociosidade, explique qual capacidade parece mais razoável.
#Responda em um comentário no script.
# Escreva aqui qual capacidade parece mais razoável, considerando saturação
# e ociosidade.
#RESPOSTA; A capacidade de 20 clientes por hora tem menor ociosidade, 
#mas gera saturação elevada: cerca de 27% das horas simuladas ficam acima da capacidade.
#Acapacidade atual de 22 clientes por hora reduz a saturação, mas ainda deixa cerca
# de 15% das horas simuladas acima da capacidade.
#A capacidade de 25 clientes por hora reduz a saturação para cerca de 5%,
#mas aumenta a capacidade ociosa média.
#Além disso, 25 clientes por hora coincide com o quatil de 95% da simulação,
#ou seja, atende aproximadamente 95% das horas simuladas.
#Se a prioridade for reduzir espera e preservar a qualidade do atendimento no pico,
# a capacidade de 25 parece mais adequada. Se o custo da ociosidade pesar mais
#e a unidade aceitar mais saturação, a capacidade atual de 22 também pode
#ser definida. A simulação não decide sozinha: ela quantifica o trade-of.


