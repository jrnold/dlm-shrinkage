greenbacks <- RDATA[["greenbacks"]]

KEY <- "greenbacks_hp"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)
MODEL <- "local_level_hp_inter"


SEED <- c(43542530304)
ITER <- 2^15
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

greenbacks2 <-
  mutate(subset(na.omit(greenbacks),
                date <= as.Date("1866-1-1")),
         ddif = as.integer(c(1, diff(date))))

standata <-
  within(list(), {
    y <- greenbacks2$lmean
    n <- length(y)
    H_a <- greenbacks2$lsd^2
    H_b <- rep(1, n)
    Q_a <- rep(0, n)
    Q_b <- greenbacks2$ddif
    a1 <- greenbacks2$lmean[1]
    P1 <- greenbacks2$lsd[1] * 3
  })

# StructTS(greenbacks$lmean, "level")
init <-
  within(list(), {
    H <- 0.001
    tau <- 4.6e-5
    lambda <- rep(1, length(standata$y))
  })

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

object <- RDATA[[MCMCDB_KEY]]

RDATA[[MCMCDB_KEY]] <- res #new("McmcdbLocalLevelHp", res)
RDATA[[SUMMARY_KEY]] <- summary(RDATA[[MCMCDB_KEY]])

make_ssm.McmcdbLocalLevelHpInter2 <- function(iter, data) {
  SSModel(data$y,
          Z = matrix(1),
          H = array(iter$H, c(1, 1, length(iter$H))),
          T = matrix(1),
          Q = array(iter$Q, c(1, 1, length(iter$Q))),
          a1 = data$a1,
          P1 = data$P1)
}

simstates.McmcdbLocalLevelHpInter2 <- function(iter, data) {
  as.numeric(simulateSSM(make_ssm.McmcdbLocalLevelHpInter2(iter, data),
                         sim = "states")[["states"]])
}

alpha <- simplify2array(mcmcdb_samples_iter(object, FUN = simstates.McmcdbLocalLevelHpInter2, data = mcmcdb_data(object)))
