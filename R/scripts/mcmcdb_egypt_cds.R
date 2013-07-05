# ---
# code: greenbacks
# ---
egypt_cds <- RDATA[["egypt_cds"]]
KEY <- "egypt_cds_1"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)
MODEL <- "level_ar1"

SEED <- c(4724536922)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

standata <-
  within(list(), {
    y <- t(matrix(egypt_cds$X5Y))
    n <- length(y)
    Z <- t(matrix(rep(1, 2)))
    R <- diag(2)
    T0 <- diag(2)
    a1_1 <- egypt_cds$X5Y[1]
    P1_1 <- var(egypt_cds$X5Y[1:30])
    c <- array(0)
    d <- array(rep(0, 2))
  })

timing <-
  system.time(smpls <- run_stan_model(STAN_MODELS(MODEL),
                                      data = standata,
                                      seed=SEED,
                                      iter = ITER,
                                      warmup = WARMUP,
                                      thin = THIN))
res <- 
  mcmcdb_wide_from_stan(smpls,
                        model_data = standata,
                        model_name = MODEL)
res@metadata[["system_time"]] <- timing
RDATA[[MCMCDB_KEY]] <- res
