nile <- RDATA[["nile"]]
source("nile_data.R")

KEY <- "nile_hs"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

MODEL <- "seatbelts1"

y <- as.numeric(datasets::UKDriverDeaths)

mod <- dlmModPoly(1) + dlmModSeas(12)

standata <- within(list(), {
  y <- y
  n <- length(y)
  F <- t(mod$FF)
  G <- mod$GG
  m0 <- c(mean(y), 0)
  C0 <- matrix(c(var(y), 0, 0, 1e7), 2, 2)
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

