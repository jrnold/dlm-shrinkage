#' @exportClass McmcdbLocalLevelNormal
#' @include sim_ssm-method.R
NULL

setClass("McmcdbLocalLevelNormal", contains = "McmcdbWide")

setGeneric("ssm_sim", function(object, data, ...) standardGeneric("ssm_sim"))

ssm_sim.McmcdbLocalLevelNormal <- function(object, data) {
  f <- function(H, Q, ...) {
    model <- SSModel(data$y,
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

setMethod("ssm_sim", "McmcdbLocalLevelNormal", ssm_sim.McmcdbLocalLevelNormal)

summary.McmcdbLocalLevelNormal <- function(object, data) {
  ret <- list()

  y <- mcmcdb_data(object)$y
  alpha <- ssm_sim(object, mcmcdb_data(object))
  ret[["alpha"]] <- alpha
  ret[["mu"]] <- alpha
  f_yrep <- function(alpha, H, ...) {
    alpha <- unlist(alpha)
    n <- length(alpha)
    rnorm(n, alpha, sqrt(H))
  }
  yrep <-
    simplify2array(mlply(data.frame(alpha = I(alply(alpha, 1, identity)),
                                    H = as.numeric(object[["H"]])),
                         f_yrep))
  ret[["yrep"]] <- yrep

  f_loglik <- function(alpha, H, y) {
    alpha <- unlist(alpha)
    n <- length(alpha)
    dnorm(y, alpha, sqrt(H), log = TRUE)
  }
  loglik <-
    simplify2array(mlply(data.frame(alpha = I(alply(alpha, 1, identity)),
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

setMethod("summary", "McmcdbLocalLevelNormal",
          summary.McmcdbLocalLevelNormal)
