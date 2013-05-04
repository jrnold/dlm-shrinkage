data(Nile)
nile <- RDATA[["nile"]]

model_hs <- "../stan/models/horseshoe.stanx"
model_normal <- "../stan/models/normal.stanx"
model_normal2 <- "../stan/models/normal2.stanx"

SEED <- c(64425843)
ITER <- 2^8
WARMUP <- 2^2
NSAMPLES <- 2^4
THIN <- (ITER - WARMUP) / NSAMPLES

nile_data <- list(n_obs = length(nile),
                  theta1_mean = nile[1],
                  theta1_sd = sd(nile))

nile_smpl_output_normal <-
  run_stan_model(model_normal,
                 data = nile_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_nile_normal"]] <-
  new("McmcdbNormal",
      mcmcdb_wide_from_stan(nile_smpl_output_normal,
                            model_name = "normal"))

nile_smpl_output_hs <-
  run_stan_model(model_hs,
                 data = nile_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_nile_hs"]] <-
  new("McmcdbHorseshoe",
      mcmcdb_wide_from_stan(nile_smpl_output_hs,
                            model_name = "horseshoe"))

nile_smpl_output_normal2 <-
  run_stan_model(model_normal2,
                 data = nile_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_nile_normal2"]] <-
  new("McmcdbNormal2", mcmcdb_wide_from_stan(nile_smpl_output_normal2,
                                            model_name = "normal2"))

