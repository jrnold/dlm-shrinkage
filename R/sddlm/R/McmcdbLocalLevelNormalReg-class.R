#' @exportClass McmcdbLocalLevelNormalReg
#' @include sim_ssm-method.R
NULL

setClass("McmcdbLocalLevelNormalReg", contains = "McmcdbWide")

ssm_sim.McmcdbLocalLevelNormalReg <- function(object, data) {
  f <- function(H, Q, beta, ...) {
    cc <- data$X %*% beta
    model <- SSModel(data$y - cc,
                     Z = matrix(1),
                     H = H,
                     T = matrix(1),
                     Q = Q,
                     a1 = data$a1,
                     P1 = data$P1)
    as.numeric(simulateSSM(model, "state")[["states"]])
  }
  mcmcdb_samples_iter(object, FUN = splat(f), return_type = "a")
}

setMethod("ssm_sim", "McmcdbLocalLevelNormalReg", ssm_sim.McmcdbLocalLevelNormalReg)

summary.McmcdbLocalLevelNormalReg <- function(object, data) {
  ret <- list()

  data <- mcmcdb_data(object)
  y <- mcmcdb_data(object)$y
  alpha <- ssm_sim(object, mcmcdb_data(object))
  ret[["alpha"]] <- alpha
  ret[["mu"]] <- alpha + t(sapply(object[["beta"]], `*`, y = data$X))
  f_yrep <- function(alpha, H, beta, data, ...) {
    mu <- unlist(alpha) + beta * data$X
    n <- length(mu)
    rnorm(n, mu, sqrt(H))
  }
  yrep <-
    simplify2array(mlply(data.frame(alpha = I(alply(alpha, 1, identity)),
                                    beta = as.numeric(object[["beta"]]),
                                    H = as.numeric(object[["H"]])),
                         f_yrep, data = data))
  ret[["yrep"]] <- yrep

  f_loglik <- function(alpha, H, beta, y) {
    mu <- unlist(alpha) + beta * data$X
    n <- length(mu)
    dnorm(y, mu, sqrt(H), log = TRUE)
  }
  loglik <-
    simplify2array(mlply(data.frame(alpha = I(alply(alpha, 1, identity)),
                                    beta = as.numeric(object[["beta"]]),
                                    H = as.numeric(object[["H"]])),
                         f_loglik, y = mcmcdb_data(object)$y))
  ret[["loglik"]] <- loglik
  ret[["eta"]] <- aaply(cbind(mcmcdb_data(object)$a1, alpha), 1, diff)
  ret[["yhat"]] <- apply(yrep, 1, mean)
  ret[["yvar"]] <- apply(yrep, 1, var)
  ret[["lppd"]] <- log(apply(exp(ret[["loglik"]]), 1, mean))
  ret[["waic"]] <- waic(ret[["loglik"]])
  ret[["mse"]] <- discrepancy(y, yrep, "mse")
  ret[["chisq"]] <- discrepancy(y, yrep, "chisq")
  ret
}

setMethod("summary", "McmcdbLocalLevelNormalReg",
          summary.McmcdbLocalLevelNormalReg)
