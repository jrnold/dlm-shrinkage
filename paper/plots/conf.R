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

