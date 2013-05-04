#' @include smgdlm-package.R
#' @exportClass McmcdbNormal
NULL

setClass("McmcdbNormal", contains = "McmcdbWide")

summary.McmcdbNormal <- function(object, y) {
  ret <- list()
  f <- function(x) rnorm(length(x$theta), x$theta, x$sigma)
  yrep <- simplify2array(mcmcdb_samples_iter(object, FUN = f))
  ret[["yrep"]] <- yrep
  ret[["yhat"]] <- apply(yrep, 1, mean)
  ret[["lppd"]] <- log(apply(exp(object[["llik"]]), 1, mean))
  ret[["waic"]] <- waic(object[["llik"]])
  ret[["mse"]] <- discrepancy(y, yrep, "mse")
  ret[["chisq"]] <- discrepancy(y, yrep, "chisq")
  ret[["w"]] <- 1 - mean(1 / (1 + object[["tau"]]))
  ret[["errors"]] <- apply(object[["theta"]], 2, `-`, y = y)
  innovations <- apply(object[["theta"]], 2, diff)
  ret[["innovations"]] <- innovations
  ret[["ppos"]] <- apply(innovations, 1, prgt0)
  ret[["pneg"]] <- apply(innovations, 1, prlt0)
  ret[["hpd95"]] <- apply(innovations, 1, hpd_interval, prob=0.95)
  ret[["hpd75"]] <- apply(innovations, 1, hpd_interval, prob=0.75)
  ret
}

setMethod("summary", "McmcdbNormal", summary.McmcdbNormal)
