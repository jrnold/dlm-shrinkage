suppressPackageStartupMessages({
  library("filehash")
  library("plyr")
  library("boot")
  library("mcmcdb")
  library("stanmisc")
})

ROOT_DIR <- normalizePath(".")
STAN_MODEL_DIR <- file.path(ROOT_DIR, "stan/models")
FILEHASH_DB <- file.path(ROOT_DIR, "rdata")
RDATA <- dbInit(FILEHASH_DB, "RDS")
