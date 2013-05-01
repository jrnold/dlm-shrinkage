library(stanmisc)
library(mcmcdb)
data(Nile)

model_hs <- "../stan/models/horseshoe.stanx"
model_normal <- "../stan/models/normal.stanx"
model_normal2 <- "../stan/models/normal2.stanx"

SEED <- c(64425843)
ITER <- 2^16
WARMUP <- 2^14
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

nile <- as.numeric(Nile)
nile_data <- list(n_obs = length(nile),
                  y = nile,
                  x = c(rep(0, 27), rep(1, length(nile) - 27)),
                  theta1_mean = nile[1],
                  theta1_sd = sd(nile))

nile_smpl_output_normal <-
  run_stan_model(model_normal,
                 data = nile_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_nile_normal"]] <-
  mcmcdb_wide_from_stan(nile_smpl_output_normal,
                        model_name = "normal")

nile_smpl_output_hs <-
  run_stan_model(model_hs,
                 data = nile_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_nile_hs"]] <-
  mcmcdb_wide_from_stan(nile_smpl_output_hs,
                        model_name = "horseshoe")

nile_smpl_output_normal2 <-
  run_stan_model(model_normal2,
                 data = nile_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_nile_normal2"]] <-
  mcmcdb_wide_from_stan(nile_smpl_output_normal2,
                        model_name = "normal2")

