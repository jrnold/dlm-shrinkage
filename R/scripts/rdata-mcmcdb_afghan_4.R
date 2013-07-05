# ---
# rdata: afghanistan_fatalities
# ---

KEY <- "afghan_4"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)
MODEL <- "afghan_4"

SEED <- c(43002)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

afghanistan_fatalities <- RDATA[["afghanistan_fatalities"]]
y <- log(afghanistan_fatalities[["fatalities"]] + 0.5)

mod <- dlm::dlmModPoly(2) + dlm::dlmModTrig(s = 12, q = 1)

Z <- mod$FF
R <- diag(4)
R[1, 2] <- 1
T <- mod$GG

a1 <- rep(NA, 4)
a1[1] <- log(afghanistan_fatalities$fatalities[1])
a1[2] <- exp(0)
a1[3:4] <- 0

P1d <- rep(NA, 4)
P1d[1] <- var(log(afghanistan_fatalities$fatalities[1:12])) * 2
P1d[2] <- var(diff(log(afghanistan_fatalities$fatalities[1:13]))) * 2
P1d[3:4] <- 1e7
P1 <- diag(P1d)

standata <- within(list(), {
  y <- t(y)
  n <- length(y)
  T <- T
  Z <- Z
  R <- R
  p <- 1L
  m <- ncol(Z)
  r <- ncol(R)
  c <- array(0, p)
  d <- array(0, m)
  a1 <- a1
  P1 <- P1
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
RDATA[[MCMCDB_KEY]] <- new("DlmAfghan4", res)
