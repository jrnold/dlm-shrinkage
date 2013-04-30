library(stanmisc)
library(mcmcdb)
data(Nile)

model_hs <- "../stan/models/horseshoe"
model_normal <- "../stan/models/normal"
model_normal4 <- "../stan/models/normal4"

SEED <- c(64425843)
ITER <- 2^16
WARMUP <- 2^14
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

nile <- as.numeric(Nile)
nile_data <- list(n_obs = length(nile),
                  n_time = length(nile),
                  y = nile,
                  y_time = seq_along(nile),
                  x = c(rep(0, 27), rep(1, length(nile) - 27)),
                  theta1_mean = nile[1],
                  theta1_sd = sd(nile))

nile_smpl_output_normal <-
  run_stan_model(model_normal,
                 data = nile_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_nile_normal"]] <-
  mcmcdb_wide_from_stan(nile_smpl_output_normal)

nile_smpl_output_hs <-
  run_stan_model(model_hs,
                 data = nile_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_nile_hs"]] <-
  mcmcdb_wide_from_stan(nile_smpl_output_hs)

nile_smpl_output_normal2 <-
  run_stan_model(model_normal4,
                 data = nile_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_nile_normal2"]] <-
  mcmcdb_wide_from_stan(nile_smpl_output_normal2)

