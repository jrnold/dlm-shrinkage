#' DLM Observation Disturbances
#'
#' Returnes the estimated observation disturbances of
#' a dynamic linear model.
#'
#' @param y Data
#' @param m Latent states
#' @param mod An object of class \code{dlm}
#' @return \code{array}
#' @export
dlmNu <- function(y, m, mod) {
  FUN <- function(i) {
    F_i <- dlmGet(mod, "F", i)
    if (is.null(dim(y))) y_i <- y[i]
    else y_i <- y[i, ]
    y_i - F_i %*% t(m[i, , drop=FALSE])
  }
  laply(seq_len(nrow(m)), FUN)
}

