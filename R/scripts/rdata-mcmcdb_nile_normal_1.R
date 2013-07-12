# ---
# rdata: nile
# scripts: nile_data.R
# stan: local_level_normal
# ---
nile <- RDATA[["nile"]]
source("nile_data.R")

KEY <- "nile_normal_1"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^12
WARMUP <- 2^11
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

MODEL <- "local_level"

standata <- within(nile_data, {
  F <- matrix(1)
  G <- matrix(1)
})

iter <- list(sigma = 120.9, tau = 0.38)

timing <-
  system.time(smpls <- run_stan_model(STAN_MODELS(MODEL),
                                      data = standata, seed=SEED,
                                      iter = ITER,
                                      warmup = WARMUP,
                                      thin = THIN))
res <- 
  mcmcdb_wide_from_stan(smpls,
                        model_data = nile_data,
                        model_name = MODEL)
res@metadata[["system_time"]] <- timing
RDATA[[MCMCDB_KEY]] <- new("BsDlmLocalLevel", res)
