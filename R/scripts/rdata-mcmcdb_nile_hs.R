# depends: $(RDATA_DIR)/nile nile_data.R $(STAN_DIR)/local_level_hs.stan
nile <- RDATA[["nile"]]
source("nile_data.R")

KEY <- "nile_hs"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)
MODEL <- "local_level_hs"

SEED <- c(43542530304)
ITER <- 2^15
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

init <-
  within(list(), {
    H <- 15099
    tau <- sqrt(1469)
    lambda <- rep(1, length(nile_data$y))
  })

timing <-
  system.time(smpls <- run_stan_model(STAN_MODELS(MODEL),
                                      data = nile_data, seed=SEED,
                                      init = init,
                                      iter = ITER,
                                      warmup = WARMUP,
                                      thin = THIN))
res <- 
  mcmcdb_wide_from_stan(smpls,
                        model_data = nile_data,
                        model_name = MODEL)
res@metadata[["system_time"]] <- timing

RDATA[[MCMCDB_KEY]] <- new("DlmLocalLevelHs", res)
