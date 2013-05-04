.libPaths(c("./R/library", .libPaths())

suppressPackageStartupMessages({
  library("filehash")
  library("plyr")
  library("boot")
  library("reshape2")
  
  library("mcmcdb")
  library("stanmisc")
  library("mcmcstats")
  library("stanmisc")
})

ROOT_DIR <- normalizePath(".")
STAN_MODEL_DIR <- file.path(ROOT_DIR, "stan/models")
FILEHASH_DB <- file.path(ROOT_DIR, "rdata")
RDATA <- dbInit(FILEHASH_DB, "RDS")
