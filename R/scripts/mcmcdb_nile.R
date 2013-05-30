nile <- RDATA[["nile"]]

SEED <- c(64425843)
ITER <- 2^16
WARMUP <- 2^13
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

nile_data <- list(n_obs = nrow(nile),
                  y = nile$flow,
                  x = as.integer(nile$dam),
                  theta1_mean = nile$flow[1],
                  theta1_sd = sd(nile$flow))

nile_smpl_output_normal <-
  run_stan_model(STAN_MODELS["normal"],
                 data = nile_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_nile_normal"]] <-
  new("McmcdbNormal",
      mcmcdb_wide_from_stan(nile_smpl_output_normal,
                            model_name = "normal"))

nile_smpl_output_hs <-
  run_stan_model(STAN_MODELS["horseshoe"],
                 data = nile_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_nile_hs"]] <-
  new("McmcdbHorseshoe",
      mcmcdb_wide_from_stan(nile_smpl_output_hs,
                            model_name = "horseshoe"))

nile_smpl_output_normal2 <-
  run_stan_model(STAN_MODELS["normal2"],
                 data = nile_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_nile_normal2"]] <-
  new("McmcdbNormal2", mcmcdb_wide_from_stan(nile_smpl_output_normal2,
                                            model_name = "normal2"))

##################

ITER <- 2^10
WARMUP <- 2^9
NSAMPLES <- 2^9
THIN <- (ITER - WARMUP) / NSAMPLES

nile_data_kf <-
  nile_data <- list(n = nrow(nile),
                    y = nile$flow,
                    missing = rep(0L, length(nile$flow)),
                    a1 = nile$flow[1],
                    P1 = var(nile$flow))

nile_kf_normal <- 
  run_stan_model(STAN_MODELS["local_level_normal"],
                 data = nile_data_kf, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
foo <- mcmcdb_wide_from_stan(nile_kf_normal)

nile_kf_hp <- 
  run_stan_model(STAN_MODELS["local_level_hp"],
                 data = nile_data_kf, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)

bar <- mcmcdb_wide_from_stan(nile_kf_hp)



sampler <- function(x) {
  model <- SSModel(nile$flow,
                   Z = matrix(1),
                   H = matrix(x$H),
                   T = matrix(1),
                   Q = array(x$Q, c(1, 1, length(x$Q))))
  as.numeric(simulateSSM(model, "state")[["states"]])
}

alpha <- simplify2array(mcmcdb_samples_iter(bar, FUN = sampler))
