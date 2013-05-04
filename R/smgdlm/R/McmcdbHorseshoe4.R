#' @include smgdlm-package.R
#' @exportClass McmcdbHorseshoe4
NULL

setClass("McmcdbHorseshoe4", contains = "McmcdbWide")

summary.McmcdbHorseshoe4 <- function(object, y) {
  ret <- list()
  f <- function(x) rnorm(length(x$theta0), x$theta0, x$sigma)
  yrep <- simplify2array(mcmcdb_samples_iter(object, FUN = f))
  ret[["yrep"]] <- yrep
  ret[["yhat"]] <- apply(yrep, 1, mean)
  ret[["lppd"]] <- log(apply(exp(object[["llik"]]), 1, mean))
  ret[["waic"]] <- waic(object[["llik"]])
  ret[["mse"]] <- discrepancy(y, yrep, "mse")
  ret[["chisq"]] <- discrepancy(y, yrep, "chisq")
  ret[["w"]] <- 1 - apply(object[["kappa"]], 1, mean)
  ret[["errors"]] <- apply(object[["theta0"]], 2, `-`, y = y)
  innovations <- apply(object[["theta0"]], 2, diff)
  ret[["innovations"]] <- innovations
  ret[["ppos"]] <- apply(innovations, 1, prgt0)
  ret[["pneg"]] <- apply(innovations, 1, prlt0)
  ret[["hpd95"]] <- apply(innovations, 1, hpd_interval, prob=0.95)
  ret[["hpd75"]] <- apply(innovations, 1, hpd_interval, prob=0.75)
  ret
}

setMethod("summary", "McmcdbHorseshoe4", summary.McmcdbHorseshoe4)
