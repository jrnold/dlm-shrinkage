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
  # Parallel processing
  library("foreach")
  library("doMC")
})

ROOT_DIR <- normalizePath(".")
STAN_MODEL_DIR <- file.path(ROOT_DIR, "stan")
FILEHASH_DB <- file.path(ROOT_DIR, "rdata")
RDATA <- dbInit(FILEHASH_DB, "RDS")

STAN_MODELS <- function(key) {
  file.path(STAN_MODEL_DIR, sprintf("%s.stanx", key))
}

reinstall_sddlm <- function(clean=FALSE, ...) {
  sddlm <- file.path(ROOT_DIR, "R/sddlm")
  document(sddlm, clean=TRUE)
  install(sddlm, ...)
}

# Parallel
registerDoMC(5)
