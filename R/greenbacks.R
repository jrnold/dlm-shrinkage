library(stanmisc)
library(mcmcdb)
library(plyr)

model_hs <- "../stan/models/horseshoe"
model_normal <- "../stan/models/normal"

GREENBACKS <- "../data/greenbacks.csv"
MAX_DATE <- as.Date("1865-12-31")
MIN_DATE <- as.Date("1862-1-1")

SEED <- 46927922
ITER <- 2^14
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

n_time <- as.integer(MAX_DATE - MIN_DATE + 1)

greenbacks <-
  subset(mutate(read.delim(GREENBACKS),
                date = as.Date(dt),
                dt = NULL,
                y = (log(high) + log(low)) * 0.5,
                y_time = as.integer(date - MIN_DATE + 1)),
         date >= MIN_DATE & date <= MAX_DATE)
greenbacks2 <- subset(greenbacks, !is.na(y))

data <- list(n_obs = nrow(greenbacks2),
             n_time = n_time,
             y = greenbacks2$y,
             y_time = greenbacks2$y_time,
             theta1_mean = log(100),
             theta1_sd = 0.01)

init <- within(list(), {
  logsigma = log(0.05)
  theta_innov = c(0, diff(theta))
  lambda = rep(1, data$n_time - 1)
  tau = 1
})
             
greenbacks_normal <- run_stan_model(model_normal,
                                    data = data, init = init,
                                    seed=SEED,
                                    iter = ITER, warmup = WARMUP, thin = THIN)
mcmcdb_greenbacks_normal <- mcmcdb_wide_from_stan(greenbacks_normal)
save(mcmcdb_greenbacks_normal, file = "greenbacks_normal.rda")

greenbacks_hs <- run_stan_model(model_hs,
                                data = data, init = init,
                                seed=SEED,
                                iter = ITER, warmup = WARMUP, thin = THIN)
mcmcdb_greenbacks_hs <- mcmcdb_wide_from_stan(greenbacks_hs)
save(mcmcdb_greenbacks_hs, file = "greenbacks_hs.rda")
