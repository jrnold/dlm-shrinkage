#' @exportClass McmcdbLocalLevelNormalInter
#' @include sim_ssm-method.R
NULL

setClass("McmcdbLocalLevelNormalInter", contains = "McmcdbWide")

ssm_sim.McmcdbLocalLevelNormalInter <- function(object, data) {
  f <- function(H, Q, ...) {
    model <- SSModel(data$y,
                     Z = matrix(1),
                     H = H,
                     T = matrix(1),
                     Q = array(as.numeric(Q), c(1, 1, length(Q))),
                     a1 = data$a1,
                     P1 = data$P1)
    as.numeric(simulateSSM(model, "state")[["states"]])
  }
  mcmcdb_samples_iter(object, FUN = splat(f), return_type = "a")
}

setMethod("ssm_sim", "McmcdbLocalLevelNormalInter",
          ssm_sim.McmcdbLocalLevelNormalInter)

setMethod("summary", "McmcdbLocalLevelNormalInter",
          summary.McmcdbLocalLevelNormal)
