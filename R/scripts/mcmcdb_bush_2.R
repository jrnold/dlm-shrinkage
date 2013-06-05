bush <- RDATA[["bush_approval"]]

standata <- within(list(), {
  n <- nrow(bush)
  y <- bush$approve
  Q_a <- rep(0, length(y))
  Q_b <- bush$ddate
  a1 <- bush$approve[1]
  P1 <- 25
})

init <- list(H = 6.3, tau = 1.45,
             lambda = rep(1, length(standata$y)))

KEY <- "bush_normal_2"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^15
WARMUP <- 2^13
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

MODEL <- "local_level_hp_inter"

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

RDATA[[MCMCDB_KEY]] <- new("McmcdbLocalLevelNormalInter", res)
RDATA[[SUMMARY_KEY]] <- summary(RDATA[[MCMCDB_KEY]])

object <- RDATA[["mcmcdb_bush_normal_1"]]

