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
      T <- matrix(1, 2, 2)
      T[2, 1] <- 0
      T[2, 2] <- iter$rho
      R <- matrix(c(0, 1), 2, 1)
      Z <- matrix(c(1, 0), 1, 2)
      H <- array(iter$H, c(1, 1, length(iter$H)))
      Q <- array(iter$Q, c(1, 1, length(iter$Q)))
      foo <- SSModel(t(data$y),
                     Z = Z, H = H, T = T, Q = Q, R = R,
                     a1 = data$a1, P1 = data$P1)
    }
  }

setMethod("dlm_to_ssmodel", "DlmGreenbacks2",
          dlm_to_ssmodel.DlmGreenbacks2)
