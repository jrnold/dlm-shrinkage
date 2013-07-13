# ---
# rdata: nile
# scripts: nile_data.R
# stan: local_level_normal
# ---
nile <- RDATA[["nile"]]
source("nile_data.R")

KEY <- "nile_normal_2"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

MODEL <- "local_level_vw"

standata <- within(nile_data, {
  F <- matrix(1)
  G <- matrix(1)
  V_a <- rep(0, T)
  V_b <- rep(1, T)
  W_a <- rep(0, T)
  W_a[which(diff(nile$dam) > 0) + 1] <- 1e7
  W_b <- rep(1, T)
})

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

RDATA[[MCMCDB_KEY]] <- new("BsDlmLocalLevelVw", res)
