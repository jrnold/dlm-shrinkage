#' @include DLM-class.R
#' @include dlm_to_ssmodel-method.R
#' @exportClass DlmGreenbacks3
NULL

#' @rdname DLM-class
#' @aliases DlmGreenbacks3-class
setClass("DlmGreenbacks3", contains = "DLM")

dlm_to_ssmodel.DlmGreenbacks3 <-
  function(object) {
    data <- mcmcdb_data(object)
    function(iter) {
      Z <- matrix(1, 1, 2)
      H <- array(iter$H, c(1, 1, length(iter$H)))
      T <- iter$T
      R <- diag(2)
      Q <- iter$Q
      SSModel(y = as.numeric(data$y), Z = Z, H = H, T = T, R = R, Q = Q,
              a1 = a1, P1 = P1)
    }
  }

setMethod("dlm_to_ssmodel", "DlmGreenbacks3",
          dlm_to_ssmodel.DlmGreenbacks3)
