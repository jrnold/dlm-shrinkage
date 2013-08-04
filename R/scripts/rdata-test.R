KEY <- "seatbelts2"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^0
WARMUP <- 0
NSAMPLES <- 1
THIN <- (ITER - WARMUP) / NSAMPLES

MODEL <- "testing"

dlmSim <- function(mod, n=NULL) {
  y <- matrix(0, ncol=ncol(mod$V), nrow=n)
  theta <- matrix(0, ncol=ncol(mod$W), nrow=n + 1)
  
  ## Initial value
  theta[1, ] <- rmvnorm(1, mod$m0, mod$C0)
  for (i in seq_len(n)) {
    F <- dlmGet(mod, "F", i)
    G <- dlmGet(mod, "G", i)
    V <- dlmGet(mod, "V", i)
    W <- dlmGet(mod, "W", i)
    ## draw from p(theta_t | theta_{t-1})
    theta[i + 1, ] <- rmvnorm(1, G %*% theta[i, ], W)
    ## draw from p(y_t | theta_{t})
    y[i, ] <- rmvnorm(1, F %*% theta[i + 1, ], V)
  }
  list(y=y, theta=theta)
}

mod <- dlmRandom(2, 3)
V(mod) <- diag(diag(mod$V))
y <- dlmSim(mod, n = 1000)$y
LL <- dlmLL(y, mod)
filter <- dlmFilter(y, mod)

standata <- within(list(), {
  n <- nrow(mod$GG)
  r <- nrow(mod$FF)
  y <- t(y)
  T <- ncol(y)
  V <- diag(mod$V)
  W <- mod$W
  F <- t(mod$FF)
  G <- mod$G
  m0 <- array(mod$m0)
  C0 <- mod$C0
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



