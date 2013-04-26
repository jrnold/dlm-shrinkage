suppressPackageStartupMessages({
  library("mcmcdb")
  library("stanmisc")
  library("filehash")
})

ROOT_DIR <- normalizePath(".")
STAN_MODEL_DIR <- file.path(ROOT_DIR, "stan/models")
STAN_OUTPUT_DIR <- file.path(ROOT_DIR, "stan/output")
FILEHASH_DB <- file.path(ROOT_DIR, "stan/output")
RDATA <- dbInit(FILEHASH_DB, "RDS")
