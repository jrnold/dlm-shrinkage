library("ggplot2")
library("reshape2")
library("xtable")
source("../../conf.R", chdir=TRUE)

# Approximation of horseshoe density
# Theorem 1 of Carvallo et al.
dhp <- function(x) {
  K <- 1 / sqrt(2 * pi^3)
  lb <- (K / 2) * log(1 + 4 / x^2)
  ub <- K * log(1 + 2 / x^2)
  (lb + ub) / 2
}

theme_local <- function(base_size = 12) {
  (theme_gray(base_size = base_size) +
   theme(legend.position = "bottom"))
}

