data(Nile)
mcmcdb_nile_normal <- RDATA[["mcmcdb_nile_normal2"]]

disc_mse <- function(y, yrep) {
  ey <- apply(yrep, 1, mean)
  mean((y - ey)^2)
}

disc_chisq <- function(y, yrep) {
  ey <- apply(yrep, 1, mean)
  vy <- apply(yrep, 1, var)
  sum((y - ey)^2 / vy)
}


nile <-
  data.frame(year = tsp(Nile)[1]:tsp(Nile)[2],
             flow = as.numeric(Nile))

f <- function(x) rnorm(length(x$yhat), x$yhat, x$sigma)
yrep <- simplify2array(mcmcdb_samples_iter(mcmcdb_nile_normal, FUN = f))
yhat <- apply(yrep, 1, mean)

llik <- mcmcdb_nile_normal[["llik"]]
lppd <- log(apply(exp(mcmcdb_nile_normal[["llik"]]), 1, mean))
waic <- waic(llik)
dic <- dic(as.numeric(mcmcdb_nile_normal[["deviance"]]))

ggplot(mutate(nile, ymean = yhat), aes(x=year)) + geom_point(aes(y = flow)) + geom_line(aes(y = ymean))

waic(llik)

mcmcdb_nile_hs <- RDATA[["mcmcdb_nile_hs"]]

w <- 1 - apply(mcmcdb_nile_hs[["kappa"]], 1, mean)
