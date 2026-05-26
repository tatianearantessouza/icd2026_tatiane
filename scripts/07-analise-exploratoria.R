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