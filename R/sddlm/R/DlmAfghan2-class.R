#' @include DLM-class.R
#' @include dlm_to_ssmodel-method.R
#' @exportClass DlmAfghan2
NULL

#' @rdname DLM-class
#' @aliases DlmAfghan2-class
setClass("DlmAfghan2", contains = "DLM")

dlm_to_ssmodel.DlmAfghan2 <-
  function(object) {
    data <- mcmcdb_data(object)
    mod <- dlm::dlmModPoly(2) + dlm::dlmModTrig(s = 12, q = 1)
    Z <- mod$FF
    T <- mod$GG
    R <- diag(4)
    R[1, 2] <- 1

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

setMethod("dlm_to_ssmodel", "DlmAfghan2",
          dlm_to_ssmodel.DlmAfghan2)
