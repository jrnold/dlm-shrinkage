# ---
# rdata: afghanistan_fatalities
# ---

KEY <- "afghan_1"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)
#MODEL <- "greenbacks1"
MODEL <- "afghan_1"

SEED <- c(43002)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

afghanistan_fatalities <- RDATA[["afghanistan_fatalities"]]

mod <- dlm::dlmModPoly(2) + dlm::dlmModSeas(12)

Z <- mod$FF
T <- mod$GG
R <- matrix(0, nrow(T), 3)
diag(R)[1:3] <- 1
Q1 <- diag(3)
Q1[1, 2] <- 1L

a1 <- rep(NA, 13)
a1[1] <- log(afghanistan_fatalities$fatalities[1])
a1[2] <- 0
a1[3:13] <- 0

P1d <- rep(NA, 13)
P1d[1] <- var(log(afghanistan_fatalities$fatalities[1:12])) * 2
P1d[2] <- var(diff(log(afghanistan_fatalities$fatalities[1:12]))) * 2
P1d[3:13] <- 1e7
P1 <- diag(P1d)

standata <- within(list(), {
  y <- t(log(afghanistan_fatalities[["fatalities"]] + 0.5))
  n <- length(y)
  T <- T
  Z <- Z
  R <- R
  Q1 <- Q1
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
RDATA[[MCMCDB_KEY]] <- res
