nile <- RDATA[["nile"]]
set.seed(09532769)

# Summaries of the Nile models
modelk <- c("normal", "normal2", "hs")
models <- sprintf("mcmcdb_nile_%s", modelk)

disc_mse <- function(y, yrep) {
  ey <- apply(yrep, 1, mean)
  mean((y - ey)^2)
}

disc_chisq <- function(y, yrep) {
  ey <- apply(yrep, 1, mean)
  vy <- apply(yrep, 1, var)
  sum((y - ey)^2 / vy)
}

pr_positive <- function(x) sum(x > 0) / length(x)

pr_negative <- function(x) sum(x < 0) / length(x)

## pr_nonzero <- function(x) {
##   2 * (max(pr_positive(x), pr_negative(x)) - 0.5)
## }

summary_mcmcdb_nile_normal <- function(object, y) {
  ret <- list()
  f <- function(x) rnorm(length(x$theta), x$theta, x$sigma)
  yrep <- simplify2array(mcmcdb_samples_iter(object, FUN = f))
  ret[["yrep"]] <- yrep
  ret[["yhat"]] <- apply(yrep, 1, mean)
  ret[["lppd"]] <- log(apply(exp(object[["llik"]]), 1, mean))
  ret[["waic"]] <- waic(object[["llik"]])
  ret[["mse"]] <- disc_mse(y, yrep)
  ret[["chisq"]] <- disc_chisq(y, yrep)
  ret[["w"]] <- 1 - mean(1 / (1 + object[["tau"]]))
  ret[["errors"]] <- apply(object[["theta"]], 2, `-`, y = y)
  innovations <- apply(object[["theta"]], 2, diff)
  ret[["innovations"]] <- innovations
  ret[["ppos"]] <- apply(innovations, 1, pr_positive)
  ret[["pneg"]] <- apply(innovations, 1, pr_negative)
  ret[["hpd95"]] <- apply(innovations, 1, hpd_interval, prob=0.95)
  ret[["hpd75"]] <- apply(innovations, 1, hpd_interval, prob=0.75)
  ret
}

summary_mcmcdb_nile_normal2 <- function(object, y) {
  ret <- list()
  f <- function(x) rnorm(length(x$yhat), x$yhat, x$sigma)
  yrep <- simplify2array(mcmcdb_samples_iter(object, FUN = f))
  ret[["yrep"]] <- yrep
  ret[["yhat"]] <- apply(yrep, 1, mean)
  ret[["lppd"]] <- log(apply(exp(object[["llik"]]), 1, mean))
  ret[["waic"]] <- waic(object[["llik"]])
  ret[["mse"]] <- disc_mse(y, yrep)
  ret[["chisq"]] <- disc_chisq(y, yrep)
  ret[["w"]] <- 1 - mean(1 / (1 + object[["tau"]]))
  ret[["errors"]] <- apply(object[["yhat"]], 2, `-`, y = y)
  innovations <- apply(object[["yhat"]], 2, diff)
  ret[["innovations"]] <- innovations
  ret[["ppos"]] <- apply(innovations, 1, pr_positive)
  ret[["pneg"]] <- apply(innovations, 1, pr_negative)
  ret[["hpd95"]] <- apply(innovations, 1, hpd_interval, prob=0.95)
  ret[["hpd75"]] <- apply(innovations, 1, hpd_interval, prob=0.75)
  ret
}

summary_mcmcdb_nile_hs <- function(object, y) {
  ret <- list()
  f <- function(x) rnorm(length(x$theta), x$theta, x$sigma)
  yrep <- simplify2array(mcmcdb_samples_iter(object, FUN = f))
  ret[["yrep"]] <- yrep
  ret[["yhat"]] <- apply(yrep, 1, mean)
  ret[["lppd"]] <- log(apply(exp(object[["llik"]]), 1, mean))
  ret[["waic"]] <- waic(object[["llik"]])
  ret[["mse"]] <- disc_mse(y, yrep)
  ret[["chisq"]] <- disc_chisq(y, yrep)
  ret[["w"]] <- 1 - apply(object[["kappa"]], 1, mean)
  ret[["errors"]] <- apply(object[["theta"]], 2, `-`, y = y)
  innovations <- apply(object[["theta"]], 2, diff)
  ret[["innovations"]] <- innovations
  ret[["ppos"]] <- apply(innovations, 1, pr_positive)
  ret[["pneg"]] <- apply(innovations, 1, pr_negative)
  ret[["hpd95"]] <- apply(innovations, 1, hpd_interval, prob=0.95)
  ret[["hpd75"]] <- apply(innovations, 1, hpd_interval, prob=0.75)
  ret
}

summaries <- 
  llply(models,
        function(k, y) {
          get(sprintf("summary_%s", k))(RDATA[[k]], y)
        }, y = nile$flow)
names(summaries) <- modelk

RDATA[["summary_nile"]] <- summaries
