# depends: $(RDATA_DIR)/greenbacks
greenbacks <- RDATA[["greenbacks"]]

KEY <- "greenbacks3"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)
MODEL <- "greenbacks3"

SEED <- c(43542530304)
ITER <- 2^15
WARMUP <- 2^14
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

greenbacks_cw <- na.omit(subset(greenbacks,
                                date <= as.Date("1866-1-1")))

standata <-
  within(list(), {
    y <- t(matrix(greenbacks_cw$lmean))
    n <- ncol(y)
    meas_err <- greenbacks_cw$lsd^2
    meas_err[is.na(meas_err)] <- 1e7
    a1 <- c(greenbacks_cw$lmean[1], 0, 0)
    P1 <- diag(rep(greenbacks_cw$lsd[1] * 3, 3))
  })

# StructTS(greenbacks$lmean, "level")
init <-
  within(list(), {
    tau <- 0.0003813335
    sigma2 <- 3.194345e-07
    lambda <- rep(1, length(standata$y))
    rho <- 0.1
  })

timing <-
  system.time(smpls <- run_stan_model(STAN_MODELS(MODEL),
                                      data = standata,
                                      seed=SEED,
                                      #init = init,
                                      iter = ITER,
                                      warmup = WARMUP,
                                      thin = THIN))
res <- 
  mcmcdb_wide_from_stan(smpls,
                        model_data = standata,
                        model_name = MODEL)
res@metadata[["system_time"]] <- timing

RDATA[[MCMCDB_KEY]] <- res #new("McmcdbLocalLevelHp", res)
