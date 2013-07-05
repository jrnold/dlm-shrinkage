# ---
# code: greenbacks
# ---
source("greenbacks.R")

KEY <- "greenbacks5"
SUMMARY_KEY <- sprintf("summary_%s", KEY)
MODEL <- "greenbacks5"

SEED <- c(4724536922)
ITER <- 2^10
WARMUP <- 2^9
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

standata <-
  within(list(), {
    y <- t(matrix(greenbacks_cw$lmean))
    n <- length(y)
    ar <- 12

    Z <- t(matrix(c(rep(1, 2), rep(0, ar - 1))))
    T0 <- matrix(0, ar + 1, ar + 1)
    T0[1, 1] <- 1
    for (i in 1:(ar - 1)) {
      T0[i + 2, i + 1] <- 1
    }
    
    a1 <- c(array(greenbacks_cw$lmean[1], 1),
            rep(0, ar))
    P1_1 <- var(greenbacks_cw$lmean[1:30]) * 2
    R <- matrix(0, ar + 1, 2)
    R[1, 1] <- R[2, 2] <- 1
    c <- array(rep(0, 1))
    d <- array(rep(0, ar + 1))
  })

init <-
  within(list(), {
    tau <- c(0.006795129 / 2, 0.006795129 / 2)
    sigma2 <- 3.194345e-07
    rho <- 0.5 * (1:standata$ar)^2
    rho_pr_scale <- 0.5
  })

timing <-
  system.time(smpls <- run_stan_model(STAN_MODELS(MODEL),
                                      data = standata,
                                      seed=SEED,
                                      ## init = init,
                                      iter = ITER,
                                      warmup = WARMUP,
                                      thin = THIN))
res <- 
  mcmcdb_wide_from_stan(smpls,
                        model_data = standata,
                        model_name = MODEL)
res@metadata[["system_time"]] <- timing
RDATA[[MCMCDB_KEY]] <- res #new("DlmGreenbacks5", res)

