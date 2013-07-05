#' @include DLM-class.R
#' @include dlm_to_ssmodel-method.R
#' @exportClass DlmGreenbacks2
NULL

#' @rdname DLM-class
#' @aliases DlmGreenbacks2-class
setClass("DlmGreenbacks2", contains = "DLM")

dlm_to_ssmodel.DlmGreenbacks2 <-
  function(object) {
    data <- mcmcdb_data(object)
    function(iter) {
      T <- matrix(1)
      R <- matrix(1)
      Z <- matrix(1)
      H <- array(iter$H, c(1, 1, length(iter$H)))
      Q <- array(iter$Q, c(1, 1, length(iter$Q)))
      SSModel(y = as.numeric(data$y), T = T, R = R, Q = Q,
              a1 = a1, P1 = P1, Z = Z)
    }
  }

setMethod("dlm_to_ssmodel", "DlmGreenbacks2",
          dlm_to_ssmodel.DlmGreenbacks2)
