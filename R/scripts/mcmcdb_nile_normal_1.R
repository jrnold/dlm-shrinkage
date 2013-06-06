nile <- RDATA[["nile"]]
source(".nile_data.R")

KEY <- "nile_normal_1"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

MODEL <- "local_level_normal"

init <- list(H = 15099, tau = sqrt(1469))

timing <-
  system.time(smpls <- run_stan_model(STAN_MODELS(MODEL),
                                      data = nile_data, seed=SEED,
                                      init = init,
                                      iter = ITER,
                                      warmup = WARMUP,
                                      thin = THIN))
res <- 
  mcmcdb_wide_from_stan(smpls,
                        model_data = nile_data,
                        model_name = MODEL)
res@metadata[["system_time"]] <- timing


RDATA[[MCMCDB_KEY]] <- new("McmcdbLocalLevelNormal", res)
RDATA[[SUMMARY_KEY]] <- summary(RDATA[[MCMCDB_KEY]])

object <- RDATA[[MCMCDB_KEY]]
alpha <- sddlm:::ssm_sim.McmcdbLocalLevelNormal(object)

make_ssm.McmcdbLocalLevelNormal <- function(iter, data) {
  SSModel(data$y,
          Z = matrix(1),
          H = iter$H,
          T = matrix(1),
          Q = iter$Q,
          a1 = data$a1,
          P1 = data$P1)
}

ssmodels <- mcmcdb:::mcmcdb_samples_iter.McmcdbWide(object, FUN = make_ssm.McmcdbLocalLevelNormal, data = mcmcdb_data(object))

states.McmcdbLocalLevelNormal <- function(iter, data) {
  simulateSSM(make_ssm.McmcdbLocalLevelNormal(iter, data),
              sim = "states")[["states"]]
}

ssmodels <- mcmcdb:::mcmcdb_samples_iter.McmcdbWide(object, FUN = states.McmcdbLocalLevelNormal, data = mcmcdb_data(object))

states.McmcdbLocalLevelNormal <- function(iter, data) {
  KFS(make_ssm.McmcdbLocalLevelNormal(iter, data), smoothing = "none")
}

ssmodels <- mcmcdb:::mcmcdb_samples_iter.McmcdbWide(object, FUN = states.McmcdbLocalLevelNormal, data = mcmcdb_data(object))

## Calculate loglik from KFS
loglik_from_SSM <- function(object) {
  filt <- KFS(object, smooth = "none")
  dnorm(filt$v, 0, sqrt(filt$F), log=TRUE)
}

# alpha: m x 1 x n
# Z: p x m x n
# H: p x p x n
yrep1 <- function(alpha, Z, H) {
  mapply(function(alpha, Z, H) {
    p <- nrow(H)
    mu <- Z %*% alpha
    if (length(mu) > 1) {
      rmvnorm(1, mu, H)
    } else {
      rnorm(1, mu, sqrt(H))
    }
  }, alpha, Z, H)
}



yrep2 <- function(iter, data) {
  alpha <- l(make_ssm.McmcdbLocalLevelNormal(iter, data),
                       sim = "states")[["states"]]
  yrep1(as.numeric(alpha), 1, iter[["H"]])
}



iter <- mcmcdb_samples_iter(object, yrep2, data = mcmcdb_data(object))

loglike1 <- function(iter, data) {
  loglik_from_SSM(make_ssm.McmcdbLocalLevelNormal(iter, data))
}

iter <- mcmcdb_samples_iter(object, loglike1, data = mcmcdb_data(object))

setMethod("ssm_sim", "McmcdbLocalLevelNormal", ssm_sim.McmcdbLocalLevelNormal)



## ssm_yrep.McmcdbLocalLevelNormal <- function(object, alpha) {
##   fun <- function(alpha, H, ...) {
##     alpha <- unlist(alpha)
##     n <- length(alpha)
##     rnorm(n, alpha, sqrt(H))
##   }
##   simplify2array(mlply(data.frame(alpha = I(alply(alpha, 1, identity)),
##                                   H = as.numeric(object[["H"]])), fun))
## }

## summary.McmcdbLocalLevelNormal <- function(object, data) {
##   ret <- list()

##   y <- mcmcdb_data(object)$y
##   alpha <- ssm_sim(object, mcmcdb_data(object))
##   ret[["alpha"]] <- alpha
##   ret[["mu"]] <- alpha
##   f_yrep <- function(alpha, H, ...) {
##     alpha <- unlist(alpha)
##     n <- length(alpha)
##     rnorm(n, alpha, sqrt(H))
##   }
##   yrep <-
##     simplify2array(mlply(data.frame(alpha = I(alply(alpha, 1, identity)),
##                                     H = as.numeric(object[["H"]])),
##                          f_yrep))
##   ret[["yrep"]] <- yrep

##   f_loglik <- function(alpha, H, y) {
##     alpha <- unlist(alpha)
##     n <- length(alpha)
##     dnorm(y, alpha, sqrt(H), log = TRUE)
##   }
##   loglik <-
##     simplify2array(mlply(data.frame(alpha = I(alply(alpha, 1, identity)),
##                                     H = as.numeric(object[["H"]])),
##                          f_loglik, y = mcmcdb_data(object)$y))
##   ret[["loglik"]] <- loglik
##   ret[["eta"]] <- aaply(cbind(mcmcdb_data(object)$a1, alpha), 1, diff)
##   ret[["yhat"]] <- apply(yrep, 1, mean)
##   ret[["yvar"]] <- apply(yrep, 1, var)
##   ret[["lppd"]] <- log(apply(exp(ret[["loglik"]]), 1, mean))
##   ret[["waic"]] <- waic(ret[["loglik"]])
##   ret[["mse"]] <- discrepancy(y, yrep, "mse")
##   ret[["chisq"]] <- discrepancy(y, yrep, "chisq")
##   ret
## }

## setMethod("summary", "McmcdbLocalLevelNormal",
##           summary.McmcdbLocalLevelNormal)
