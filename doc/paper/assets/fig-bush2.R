# depends: .bush_fit_plot.R
FILE <- commandArgs(TRUE)[1]
source("conf.R")
source(".bush_fit_plot.R")
bush_fit_plot("mcmcsummary_bush_normal", FILE)
