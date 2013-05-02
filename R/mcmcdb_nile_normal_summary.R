# Summaries of the Nile models
modelk <- c("normal", "normal2", "hs")
models <- sprintf("mcmcdb_nile_%s", modelk)
                  
data(Nile)

nile <-
  data.frame(year = tsp(Nile)[1]:tsp(Nile)[2],
             flow = as.numeric(Nile))

disc_mse <- function(y, yrep) {
  ey <- apply(yrep, 1, mean)
  mean((y - ey)^2)
}

disc_chisq <- function(y, yrep) {
  ey <- apply(yrep, 1, mean)
  vy <- apply(yrep, 1, var)
  sum((y - ey)^2 / vy)
}

summary_mcmcdb_nile_normal <- function(object, y) {
  f <- function(x) rnorm(length(x$theta), x$theta, x$sigma)
  yrep <- simplify2array(mcmcdb_samples_iter(object, FUN = f))
  yhat <- apply(yrep, 1, mean)
  llik <- object[["llik"]]
  lppd <- log(apply(exp(object[["llik"]]), 1, mean))
  waic <- waic(llik)
  mse <- disc_mse(y, yrep)
  chisq <- disc_chisq(y, yrep)
  w <- 1 - mean(1 / (1 + object[["tau"]]))

  list(yrep = yrep, yhat = yhat, lppd = lppd, waic = waic,
       chisq = chisq, mse = mse, w = w)
}

summary_mcmcdb_nile_normal2 <- function(object, y) {
  f <- function(x) rnorm(length(x$yhat), x$yhat, x$sigma)
  yrep <- simplify2array(mcmcdb_samples_iter(object, FUN = f))
  yhat <- apply(yrep, 1, mean)
  llik <- object[["llik"]]
  lppd <- log(apply(exp(object[["llik"]]), 1, mean))
  waic <- waic(llik)
  mse <- disc_mse(y, yrep)
  chisq <- disc_chisq(y, yrep)
  w <- 1 - mean(1 / (1 + object[["tau"]]))

  list(yrep = yrep, yhat = yhat, lppd = lppd, waic = waic,
       chisq = chisq, mse = mse, w = w)
}


summary_mcmcdb_nile_hs <- function(object, y) {
  f <- function(x) rnorm(length(x$theta), x$theta, x$sigma)
  yrep <- simplify2array(mcmcdb_samples_iter(object, FUN = f))
  yhat <- apply(yrep, 1, mean)
  llik <- object[["llik"]]
  lppd <- log(apply(exp(object[["llik"]]), 1, mean))
  waic <- waic(llik)
  mse <- disc_mse(y, yrep)
  chisq <- disc_chisq(y, yrep)
  w <- 1 - apply(object[["kappa"]], 1, mean)
  list(yrep = yrep, yhat = yhat, lppd = lppd, waic = waic,
       chisq = chisq, mse = mse, w = w)
}

summaries <- 
  llply(models,
        function(k, y) {
          get(sprintf("summary_%s", k))(RDATA[[k]], y)
        }, y = nile$flow)
names(summaries) <- modelk

RDATA[["summary_nile"]] <- summaries
