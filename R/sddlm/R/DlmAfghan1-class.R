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
    mod <- dlm::dlmModPoly(2) + dlm::dlmModSeas(12)
    Z <- mod$FF
    T <- mod$GG
    R <- matrix(0, nrow(T), ncol(T))
    diag(R)[1:3] <- 1

    function(iter) {
      T <- T
      R <- R
      Z <- Z
      H <- array(iter$H, c(1, 1, length(iter$H)))
      Q <- array(iter$Q, c(1, 1, length(iter$Q)))
      SSModel(t(data$y),
              Z = Z, H = H, T = T, Q = Q, R = R,
              a1 = data$a1, P1 = data$P1)
    }
  }

setMethod("dlm_to_ssmodel", "DlmAfghan1",
          dlm_to_ssmodel.DlmAfghan1)
