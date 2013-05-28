bush_approval <-
  mutate(arrange(RDATA[["bush_approval"]], date),
         time = as.integer(date - as.Date("2001-02-01")))

SEED <- c(64425843)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

standata <- list(n_obs = nrow(bush_approval),
                 n_time = max(bush_approval$time),
                 y = bush_approval$approve,
                 y_time = bush_approval$time,
                 theta1_mean = bush_approval$approve[1],
                 theta1_sd = 5)

bush_smpl_1 <-
  run_stan_model(STAN_MODELS["horseshoe1a"],
                 data = standata, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_bush_hs"]] <-
  new("McmcdbHorseshoe1a",
      mcmcdb_wide_from_stan(bush_smpl_1,
                            model_name = "horseshoe1a"))

bush_smpl_2 <-
  run_stan_model(STAN_MODELS["normal1a"],
                 data = standata, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_bush_normal"]] <-
  new("McmcdbNormal1a",
      mcmcdb_wide_from_stan(bush_smpl_2,
                            model_name = "normal1a"))
