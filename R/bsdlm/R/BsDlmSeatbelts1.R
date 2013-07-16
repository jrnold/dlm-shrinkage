#' @include BsDlmMcmcdb-class.R
#' @include iter_to_dlm.R
#' @exportClass BsDlmSeatbelts1
NULL

setClass("BsDlmSeatbelts1", "BsDlmMcmcdb")

iter_to_dlm.BsDlmSeatbelts1 <-
  function(object, data = mcmcdb_data(object)) {
    F <- t(data$F)
    G <- data$G
    m0 <- data$m0
    C0 <- data$C0
    function(iter) {
      V <- iter$V
      W <- iter$W
      dlm(FF = F, GG = G, V = V, W = W,
          m0 = m0, C0 = C0)
    }
  }

setMethod("iter_to_dlm", "BsDlmSeatbelts1",
          iter_to_dlm.BsDlmSeatbelts1)
