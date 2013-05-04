# Summaries of the Nile models
modelk <- c("normal", "hs", "hs2", "hs4")
models <- sprintf("mcmcdb_cp6_%s", modelk)

cp6 <- RDATA[["cp6"]]

summary_mcmcdb_cp6_hs4 <- function(object, y) {
  f <- function(x) rnorm(length(x$theta0), x$theta0, x$sigma)
  yrep <- simplify2array(mcmcdb_samples_iter(object, FUN = f))
  yhat <- apply(yrep, 1, mean)
  llik <- object[["llik"]]
  lppd <- log(apply(exp(object[["llik"]]), 1, mean))
  waic <- waic(llik)
  mse <- disc_mse(y, yrep)
  chisq <- disc_chisq(y, yrep)
  errors <- apply(object[["theta0"]], 2, `-`, y = y)
  innovations <- apply(object[["theta0"]], 2, diff)
  w <- 1 - apply(object[["kappa"]], 1, mean)
  list(yrep = yrep, yhat = yhat, lppd = lppd, waic = waic,
       chisq = chisq, mse = mse, w = w)
}


summaries <- 
  llply(models,
        function(k, y) {
          get(sprintf("summary_%s", k))(RDATA[[k]], y)
        }, y = cp6$flow)
names(summaries) <- modelk

RDATA[["summary_cp6"]] <- summaries
