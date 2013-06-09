suppressPackageStartupMessages({
  library("VGAM")
  library("ggplot2")
  library("ggthemes")
  library("reshape2")
  library("xtable")
})

source("../../conf.R", chdir=TRUE)

theme_local <- function(base_size = 12) {
  (theme_minimal(base_size = base_size) +
   theme(legend.position = "bottom"))
}

mcmc3valsummary <- function(x) {
  hpd <- hpd_interval(x, 0.95)
  data.frame(mean = mean(x),
             lb = hpd[1], ub = hpd[2])
}
