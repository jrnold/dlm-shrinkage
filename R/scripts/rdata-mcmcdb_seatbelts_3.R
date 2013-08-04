KEY <- "seatbelts3"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^11
WARMUP <- 2^10
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

MODEL <- "seatbelts3"

y <- log(as.numeric(datasets::UKDriverDeaths))

mod <- dlmModPoly(1) + dlmModSeas(12)

standata <- within(list(), {
  y <- t(y)
  T <- length(y)
  n <- 12
  F <- t(mod$FF)
  G <- mod$GG
  m0 <- c(mean(as.numeric(y)), rep(0, 11))
  C0 <- matrix(0, 12, 12)
  diag(C0) <- c(var(as.numeric(y)), rep(1e7, 11))
  Wb <- rep(1, T)
  Wb[169] <- 1e7 # Jan 1983
})

timing <-
  system.time(smpls <- run_stan_model(STAN_MODELS(MODEL),
                                      data = standata, seed=SEED,
                                      iter = ITER,
                                      warmup = WARMUP,
                                      thin = THIN))
res <- 
  mcmcdb_wide_from_stan(smpls,
                        model_data = standata,
                        model_name = MODEL)
res@metadata[["system_time"]] <- timing
RDATA[[MCMCDB_KEY]] <- new("BsDlmSeatbelts3", res)
