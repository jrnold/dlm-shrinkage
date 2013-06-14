# depends: $(RDATA_DIR)/bush_approval $(STAN_DIR)/local_level_normal_inter.stan
bush <- RDATA[["bush_approval"]]

standata <- within(list(), {
  n <- nrow(bush)
  y <- bush$approve
  Q_a <- rep(0, length(y))
  Q_b <- bush$ddate
  H_a <- rep(0, length(y))
  H_b <- rep(1, length(y))
  a1 <- bush$approve[1]
  P1 <- 25
})

init <- list(sigma2 = 3.8, tau = sqrt(0.57))

KEY <- "bush_normal"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^14
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

MODEL <- "local_level_normal_inter"

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

RDATA[[MCMCDB_KEY]] <- new("DlmLocalLevelNormalInter", res)
