#' @include DLM-class.R
#' @include dlm_to_ssmodel-method.R
#' @exportClass DlmAfghan1
NULL

#' @rdname DLM-class
#' @aliases DlmAfghan1-class
setClass("DlmAfghan1", contains = "DLM")

dlm_to_ssmodel.DlmAfghan1 <-
  function(object) {
    data <- mcmcdb_data(object)
    mod <- dlm::dlmModPoly(1) + dlm::dlmModTrig(s = 12, q = 1)
    Z <- mod$FF
    T <- mod$GG
    R <- diag(3)

    function(iter) {
      T <- T
      R <- R
      Z <- Z
      H <- iter$H
      Q <- iter$Q
      SSModel(t(data$y),
              Z = Z, H = H, T = T, Q = Q, R = R,
              a1 = data$a1, P1 = data$P1)
    }
  }

setMethod("dlm_to_ssmodel", "DlmAfghan1",
          dlm_to_ssmodel.DlmAfghan1)
