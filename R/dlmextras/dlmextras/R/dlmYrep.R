#' @include utilities.R
NULL

#' DLM predicted responses
#'
#' Returns one simulation from the predicted response of
#' a dynamic linear model.
#' 
#' @param m Latent states.
#' @param mod Object of class \code{dlm}
#' @return \code{array}
#' @export
dlmYrep <- function(m, mod) {
  FUN <- function(i, mod, m) {
    F_i <- dlmGet(mod, "F", i)
    V_i <- dlmGet(mod, "V", i)
    mu <- F_i %*% m[i, ]
    as.numeric(rmvnorm(1, mu, as.matrix(V_i)))
  }
  laply(seq_len(nrow(m)), FUN, mod = mod, m = m)
}

