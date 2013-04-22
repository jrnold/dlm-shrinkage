library(stanmisc)
library(mcmcdb)
data(Nile)

model_hs <- "../stan/models/horseshoe"
model_normal <- "../stan/models/normal"

SEED <- c(64425843, 46927922, 69491313)
ITER <- 2^14
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES
  
nile <- as.numeric(Nile)
nile_data <- list(n_obs = length(nile),
                  n_time = length(nile),
                  y = nile,
                  y_time = seq_len(length(nile)),
                  theta1_mean = 919,
                  theta1_sd = 169 * 2)


nile_samples <- run_stan_model(model_hs,
                               data = nile_data, seed=SEED,
                               iter = ITER, warmup = WARMUP, thin = THIN)
mcmcdb_nile_hs <- mcmcdb_wide_from_stan(nile_samples)
plot(as.numeric(mcmcdb_nile_hs[["deviance"]]))

kappa <- do.call(rbind, mcmcdb_samples_iter(mcmcdb_nile_hs, FUN = function(x) {1 / (1 + as.numeric(x$lambda^2) * x$tau^2)}))


nile_samples_2 <- run_stan_model(model_normal,
                                 data = nile_data, seed=SEED,
                                 iter = ITER, warmup = WARMUP, thin = THIN)
mcmcdb_nile_normal <- mcmcdb_wide_from_stan(nile_samples_2)

ests <- cbind(melt(data.frame(normal = summary(mcmcdb_nile_normal)$yhat,
                              horseshoe = summary(mcmcdb_nile_hs)$yhat,
                              n = seq_along(nile)), id.var = "n"),
              y = nile)
ggplot(ests, aes(x=n)) + geom_line(aes(y=value, colour=variable)) + geom_point(aes(y=y))

plot(as.numeric(mcmcdb_nile_normal[["tau"]]))
plot(as.numeric(mcmcdb_nile_normal[["sigma"]]))
plot(as.numeric(mcmcdb_nile_normal[["deviance"]]))
