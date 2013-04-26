library(stanmisc)
library(mcmcdb)
data(Nile)

model_hs <- "../stan/models/horseshoe"
model_normal <- "../stan/models/normal"
model_normal3 <- "../stan/models/normal3"

SEED <- c(64425843)
ITER <- 2^14
WARMUP <- 2^13
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

nile <- as.numeric(Nile)

nile_data <- list(n_obs = length(nile),
                  n_time = length(nile),
                  y = nile,
                  y_time = seq_along(nile),
                  theta1_mean = nile[1],
                  theta1_sd = sd(nile))

nile_smpl_output_normal <-
  run_stan_model(model_normal,
                 data = nile_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["nile_normal"]] <-
  mcmcdb_wide_from_stan(nile_smpl_output_normal)

nile_smpl_output_hs <-
  run_stan_model(model_hs,
                 data = nile_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["nile_hs"]] <-
  mcmcdb_wide_from_stan(nile_smpl_output_hs)

nile_data2 <- nile_data
nile_data2[["theta1_mean"]] <-
  c(nile_data[["theta1_mean"]], rep(0, nile_data[["n_time"]] - 1))
nile_data2[["theta1_sd"]] <-
  c(nile_data[["theta1_sd"]], rep(0, nile_data[["n_time"]] - 1))
nile_data2[["theta1_sd"]][27] <- 1e8

nile_smpl_output_normal2 <-
  run_stan_model(model_normal3,
                 data = nile_data2, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["nile_normal2"]] <- nile_smpl_output_normal2
