iraq_z_spread <- RDATA[["iraq_z_spread"]]

KEY <- "irq_1"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

MODEL <- "local_level"

irq_data <-
  within(list(), {
    T <- nrow(iraq_z_spread)
    y <- t(iraq_z_spread$BLP_Z_SPRD_MID)
    m0 <- array(iraq_z_spread$BLP_Z_SPRD_MID[1])
    C0 <- matrix(var(iraq_z_spread$BLP_Z_SPRD_MID))
  })

standata <- within(irq_data, {
  F <- matrix(1)
  G <- matrix(1)
})

init <- list(tau = 2.52,
             sigma = 5.35)

timing <-
  system.time(smpls <- run_stan_model(STAN_MODELS(MODEL),
                                      data = standata, seed=SEED, init = init,
                                      iter = ITER,
                                      warmup = WARMUP,
                                      thin = THIN))
res <- 
  mcmcdb_wide_from_stan(smpls,
                        model_data = nile_data,
                        model_name = MODEL)
res@metadata[["system_time"]] <- timing

RDATA[[MCMCDB_KEY]] <- new("BsDlmLocalLevel", res)


