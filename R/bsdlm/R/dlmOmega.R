#' DLM system disturbances
#'
#' Return the system disturbances of a DLM model
#' given the latent states.
#'
#' @param m latent states
#' @param mod An object of class \code{dlm}.
#' @return \code{array}
dlmOmega <- function(m, mod) {
  FUN <- function(i) {
    G_i <- dlmGet(mod, "G", i - 1)
    m[i, , drop=FALSE] - G_i %*% m[i - 1, , drop=FALSE]
  }
  laply(2:nrow(m), FUN)
}

