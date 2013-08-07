#' @include utilities.R
NULL

#' DLM mean response
#'
#' Returns mean response from a DLM model.
#' 
#' @param m Latent states.
#' @param mod Object of class \code{dlm}
#' @return \code{array}
#' @export
dlmMu <- function(m, mod) {
  FUN <- function(i) {
    F_i <- dlmGet(mod, "F", i)
    F_i %*% m[i, ]
  }
  laply(seq_len(nrow(m)), FUN)
}
