#' @include smgdlm-package.R
#' @exportClass McmcdbNormal2
NULL

setClass("McmcdbNormal2", contains = "McmcdbWide")

summary.McmcdbNormal2 <- function(object, y) {
  ret <- list()
  f <- function(x) rnorm(length(x$yhat), x$yhat, x$sigma)
  yrep <- simplify2array(mcmcdb_samples_iter(object, FUN = f))
  ret[["yrep"]] <- yrep
  ret[["yhat"]] <- apply(yrep, 1, mean)
  ret[["lppd"]] <- log(apply(exp(object[["llik"]]), 1, mean))
  ret[["waic"]] <- waic(object[["llik"]])
  ret[["mse"]] <- discrepancy(y, yrep, "mse")
  ret[["chisq"]] <- discrepancy(y, yrep, "chisq")
  ret[["w"]] <- 1 - mean(1 / (1 + object[["tau"]]))
  ret[["errors"]] <- apply(object[["yhat"]], 2, `-`, y = y)
  innovations <- apply(object[["yhat"]], 2, diff)
  ret[["innovations"]] <- innovations
  ret[["ppos"]] <- apply(innovations, 1, prgt0)
  ret[["pneg"]] <- apply(innovations, 1, prlt0)
  ret[["hpd95"]] <- apply(innovations, 1, hpd_interval, prob=0.95)
  ret[["hpd75"]] <- apply(innovations, 1, hpd_interval, prob=0.75)
  ret
}

setMethod("summary", "McmcdbNormal2", summary.McmcdbNormal2)
