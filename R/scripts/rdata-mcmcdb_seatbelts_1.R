KEY <- "seatbelts1"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^10
WARMUP <- 2^9
NSAMPLES <- 2^9
THIN <- (ITER - WARMUP) / NSAMPLES

MODEL <- "seatbelts1"

y <- log(as.numeric(datasets::UKDriverDeaths))

mod <- dlmModPoly(1) + dlmModSeas(12)

standata <- within(list(), {
  y <- t(y)
  T <- length(y)
  F <- t(mod$FF)
  G <- mod$GG
  n <- ncol(G)
  m0 <- array(rep(0, n))
  C0 <- diag(rep(1e7, n))
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
RDATA[[MCMCDB_KEY]] <- new("BsDlmSeatbelts1", res)
