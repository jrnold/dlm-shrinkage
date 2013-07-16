KEY <- "seatbelts2"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

MODEL <- "seatbelts2"

y <- log(as.numeric(datasets::UKDriverDeaths))

mod <- dlmModPoly(1) + dlmModSeas(12)

standata <- within(list(), {
  y <- t(y)
  T <- length(y)
  n <- 12
  F <- t(mod$FF)
  G <- mod$GG
  m0 <- rep(0, n)
  C0 <- matrix(0, n, n)
  diag(C0) <- rep(1e7, n)
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
RDATA[[MCMCDB_KEY]] <- new("BsDlmSeatbelts2", res)
