nile <- RDATA[["nile"]]


KEY <- "nile_hp"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)
MODEL <- "local_level_hp"

SEED <- c(43542530304)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

init <-
  within(list(), {
    H <- 15099
    tau <- 1469 / 15099
    lambda <- rep(0.001, nile_data$n)
    lambda[28] <- 2.1
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
