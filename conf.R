libPaths(c("./R/library", .libPaths()))

suppressPackageStartupMessages({
  # CRAN
  library("filehash")
  library("plyr")
  library("reshape2")
  library("boot")
  library("dlm")
  library("reshape2")
  library("digest")
  library("devtools")
  # github/jrnold
  library("mcmcdb")
  library("stanmisc")
  library("mcmcstats")
  library("stanmisc")
  # local
  library("bsdlm")
  # Parallel processing
  library("foreach")
  library("doMC")
})

ROOT_DIR <- normalizePath(".")
STAN_MODEL_DIR <- file.path(ROOT_DIR, "stan")
DATA_DIR <- file.path(ROOT_DIR, "data")
R_DIR <- file.path(ROOT_DIR, "R")
FILEHASH_DB <- file.path(ROOT_DIR, "rdata")
RDATA <- dbInit(FILEHASH_DB, "RDS")

STAN_MODELS <- function(key) {
  file.path(STAN_MODEL_DIR, sprintf("%s.stanx", key))
}

DATA_FILE <- function(file) {
  file.path(DATA_DIR, file)
}

GET_INIT <- function(key) {
  filename <- file.path(R_DIR, "scripts/init")
  if (file.exists(file.path(R_DIR, "scripts/init"))) {
    source_env(filename)
  } else {
    NULL
  }
}

reinstall_bsdlm <- function(clean=FALSE, ...) {
  bsdlm <- file.path(ROOT_DIR, "R/bsdlm")
  document(bsdlm, clean=TRUE)
  install(bsdlm, ...)
}

# Parallel
registerDoMC(5)
