#' @include BsDlmMcmcdb-class.R
#' @include iter_to_dlm.R
#' @exportClass BsDlmLocalLevelVw
NULL

setClass("BsDlmLocalLevelVw", "BsDlmMcmcdb")

iter_to_dlm.BsDlmLocalLevelVw <-
  function(object, data = mcmcdb_data(object)) {
    F <- matrix(1)
    G <- matrix(1)
    m0 <- data$m0
    C0 <- data$C0
    function(iter) {
      V <- matrix(0)
      W <- matrix(0)
      JV <- matrix(1)
      JW <- matrix(2)
      X <- cbind(as.numeric(iter$V),
                 as.numeric(iter$W))
      dlm(FF = F, GG = G, V = V, W = W,
          JV = JV, JW = JW, X = X,
          m0 = m0, C0 = C0)
    }
  }

setMethod("iter_to_dlm", "BsDlmLocalLevelVw",
          iter_to_dlm.BsDlmLocalLevelVw)
