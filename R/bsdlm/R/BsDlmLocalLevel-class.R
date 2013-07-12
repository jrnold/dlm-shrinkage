#' @include BsDlmMcmcdb-class.R
#' @include iter_to_dlm.R
#' @exportClass BsDlmLocalLevel
NULL

setClass("BsDlmLocalLevel", "BsDlmMcmcdb")

iter_to_dlm.BsDlmLocalLevel <-
  function(object, data = mcmcdb_data(object)) {
    F <- matrix(1)
    G <- matrix(1)
    m0 <- data$m0
    C0 <- data$C0
    function(iter) {
      dlm(FF = F, GG = G,
          V = iter$V, W = iter$W, m0 = m0, C0 = C0)
    }
  }

setMethod("iter_to_dlm", "BsDlmLocalLevel",
          iter_to_dlm.BsDlmLocalLevel)
