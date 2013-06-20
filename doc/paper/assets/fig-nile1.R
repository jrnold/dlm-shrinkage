# RDATA: mcmcsummary_nile_hs
# LOCAL: .nile_fit_plot.R
FILE <- commandArgs(TRUE)[1]
source("conf.R")
source(".nile_fit_plot.R")
nile_fit_plot("mcmcsummary_nile_hs", FILE)
