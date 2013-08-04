#' @include BsDlmMcmcdb-class.R
#' @include iter_to_dlm.R
#' @exportClass BsDlmSeatbelts3
NULL

setClass("BsDlmSeatbelts3", "BsDlmMcmcdb")

iter_to_dlm.BsDlmSeatbelts3 <-
  function(object, data = mcmcdb_data(object)) {
    F <- t(data$F)
    G <- data$G
    m0 <- data$m0
    C0 <- data$C0
    function(iter) {
      V <- iter$V
      W <- iter$W[1, , ]
      JW <- matrix(0, nrow(W), ncol(W))
      JW[1, 1] <- 1
      X <- iter$W[ , 1, 1]
      dlm(FF = F, GG = G, V = V, W = W,
          JW = JW, X = X, m0 = m0, C0 = C0)
    }
  }

setMethod("iter_to_dlm", "BsDlmSeatbelts3",
          iter_to_dlm.BsDlmSeatbelts3)
