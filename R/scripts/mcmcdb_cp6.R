SEED <- c(64425843)
ITER <- 2^16
WARMUP <- 2^13
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

cp6 <- RDATA[["cp6"]]

cp6_data <- list(n_obs = nrow(cp6),
                 y = cp6[["sales"]],
                 theta1_mean = 610,
                 theta1_sd = 50,
                 nu = 4)

cp6_smpl1 <- run_stan_model(STAN_MODELS["normal"],
                            data = cp6_data, seed=SEED,
                            iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_cp6_normal"]] <-
  new("McmcdbNormal",
      mcmcdb_wide_from_stan(cp6_smpl1, model_name = "normal"))

cp6_smpl2 <- run_stan_model(STAN_MODELS["horseshoe"],
                            data = cp6_data, seed=SEED,
                            iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_cp6_hs"]] <-
  new("McmcdbHorseshoe",
      mcmcdb_wide_from_stan(cp6_smpl2, model_name = "horseshoe"))

cp6_smpl3 <- run_stan_model(STAN_MODELS["horseshoe2"],
                            data = cp6_data, seed=SEED,
                            iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_cp6_hs2"]] <-
  new("McmcdbHorseshoe2",
      mcmcdb_wide_from_stan(cp6_smpl3, model_name = "horseshoe2"))

cp6_data_2 <- list(n_obs = nrow(cp6),
                   y = cp6[["sales"]],
                   theta_mean = c(610, 0),
                   theta_sd = c(50, 50),
                   nu = 4)

cp6_smpl4 <- run_stan_model(STAN_MODELS["horseshoe4"],
                            data = cp6_data_2,
                            seed=SEED, iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_cp6_hs4"]] <-
  new("McmcdbHorseshoe4",
      mcmcdb_wide_from_stan(cp6_smpl4, model_name = "horseshoe4"))
