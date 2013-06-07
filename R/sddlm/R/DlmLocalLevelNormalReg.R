#' @exportClass DlmLocalLevelNormalReg
#' @include DLM-class.R
#' @include dlm_to_ssmodel-method.R
NULL

#' @rdname DLM-class
#' @aliases DlmLocalLevelNormalReg-class
setClass("DlmLocalLevelNormalReg", contains = "DLM")

dlm_to_ssmodel.DlmLocalLevelNormalReg <-
  function(object) {
    data <- mcmcdb_data(object)
    .local <- function(iter) {
      mu <- data$X %*% iter$beta
      SSModel(data$y - mu,
              Z = matrix(1),
              H = iter$H,
              T = matrix(1),
              Q = iter$Q,
              a1 = data$a1,
              P1 = data$P1)
    }
    .local
  }

setMethod("dlm_to_ssmodel", "DlmLocalLevelNormalReg",
          dlm_to_ssmodel.DlmLocalLevelNormalReg)
