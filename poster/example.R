# library("devtools"); install_github("mcmcdb", "jrnold")
library("mcmcdb")
library("dlm")
# function to convert iteration data to dlm object
# to_dlm <- function(iter) { ... }
FUN <- function(iter) {
  dlmBSample(dlmFilter(to_dlm(iter)))
}
theta_samples <- mcmcdb_samples_iter(samples, FUN)
