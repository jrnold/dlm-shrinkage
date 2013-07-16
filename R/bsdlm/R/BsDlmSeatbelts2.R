#' @include BsDlmMcmcdb-class.R
#' @include iter_to_dlm.R
#' @exportClass BsDlmSeatbelts2
NULL

setClass("BsDlmSeatbelts2", "BsDlmMcmcdb")

iter_to_dlm.BsDlmSeatbelts2 <-
  function(object, data = mcmcdb_data(object)) {
    F <- t(data$F)
    G <- data$G
    m0 <- data$m0
    C0 <- data$C0
    function(iter) {
      V <- iter$V
      W <- matrix(1)
      JW <- matrix(1)
      X <- cbind(as.numeric(iter$W))
      dlm(FF = F, GG = G, V = V, W = W,
          JW = JW, X = X, m0 = m0, C0 = C0)
    }
  }

setMethod("iter_to_dlm", "BsDlmSeatbelts2",
          iter_to_dlm.BsDlmSeatbelts2)
