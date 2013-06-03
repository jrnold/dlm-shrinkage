.libPaths(c("./R/library", .libPaths()))

suppressPackageStartupMessages({
  # CRAN
  library("filehash")
  library("plyr")
  library("boot")
  library("reshape2")
  # github/jrnold
  library("mcmcdb")
  library("stanmisc")
  library("mcmcstats")
  library("stanmisc")
  # local
  library("sddlm")
})

ROOT_DIR <- normalizePath(".")
STAN_MODEL_DIR <- file.path(ROOT_DIR, "stan/models")
FILEHASH_DB <- file.path(ROOT_DIR, "rdata")
RDATA <- dbInit(FILEHASH_DB, "RDS")

STAN_MODELS <-
  sapply(gsub("\\.stanx$", "", dir(STAN_MODEL_DIR, pattern="\\.stanx")),
         function(x) file.path(STAN_MODEL_DIR, sprintf("%s.stanx", x)))
