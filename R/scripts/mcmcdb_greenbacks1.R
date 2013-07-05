# ---
# code: greenbacks
# ---
source("greenbacks.R")

KEY <- "greenbacks1"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)
MODEL <- "greenbacks1"

SEED <- c(4724536922)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

standata <-
  within(list(), {
    y <- t(matrix(greenbacks_cw$lmean))
    missing <- is.na(y)
    n <- length(y)
    meas_err <- greenbacks_cw$lsd^2
    meas_err[is.na(meas_err)] <- 1e7
    a1 <- array(greenbacks_cw$lmean[1], 1)
    P1 <- matrix(greenbacks_cw$lsd[1]^2 * 2)
    Z <- matrix(1)
    T <- matrix(1)
    R <- matrix(1)
    c <- array(0, 1)
    d <- array(0, 1)
  })

foo <- StructTS(greenbacks$lmean, "level")
init <-
  within(list(), {
    tau <- 0.006795129 
    sigma2 <- 3.194345e-07
  })

timing <-
  system.time(smpls <- run_stan_model(STAN_MODELS(MODEL),
                                      data = standata,
                                      seed=SEED,
                                      init = init,
                                      iter = ITER,
                                      warmup = WARMUP,
                                      thin = THIN))
res <- 
  mcmcdb_wide_from_stan(smpls,
                        model_data = standata,
                        model_name = MODEL)
res@metadata[["system_time"]] <- timing
RDATA[[MCMCDB_KEY]] <- new("DlmGreenbacks1", res)
