nile <- RDATA[["nile"]]
source(".nile_data.R")

KEY <- "nile_hp_3"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)
MODEL <- "local_level_hp_v3"

SEED <- c(43542530304)
ITER <- 2^14
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

init <-
  within(list(), {
    H <- 15099
    tau <- sqrt(1469 / H)
    lambda <- rep(1, nile_data$n)
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

RDATA[[MCMCDB_KEY]] <- new("McmcdbLocalLevelHp", res)
RDATA[[SUMMARY_KEY]] <- summary(RDATA[[MCMCDB_KEY]])
