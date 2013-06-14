# depends: $(RDATA_DIR)/bush_approval $(STAN_DIR)/spline_hs.stan
bush <- RDATA[["bush_approval"]]

standata <- within(list(), {
  n <- nrow(bush)
  y <- bush$approve
  ydiff <- bush$ddate
  a1 <- array(c(bush$approve[1], 0), 2)
  P1 <- matrix(c(25, 0, 0, 5), 2, 2)
})

MODEL <- "spline_hs"
KEY <- "bush_spline_hs"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^15
WARMUP <- 2^13
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

init <- list(tau = 0.16, lambda = rep(0.001, standata$n))

timing <-
  system.time(smpls <- run_stan_model(STAN_MODELS(MODEL),
                                      data = standata, seed=SEED,
                                      init = init,
                                      iter = ITER,
                                      warmup = WARMUP,
                                      thin = THIN))
res <- 
  mcmcdb_wide_from_stan(smpls,
                        model_data = standata,
                        model_name = MODEL)
res@metadata[["system_time"]] <- timing

RDATA[[MCMCDB_KEY]] <- new("DlmSplineHs", res)
