#' @include utilities.R
NULL

#' DLM Log Likelihood
#'
#' Log likelihood of a dynamic linear model for each observation.
#'
#' @param x An object of class \code{"dlmFiltered"}
#' @param y observed data
#' @export
dlmLogLikObs <- function(x, y = NULL) {
  n <- nrow(as.matrix(x$f))
  R <- dlmSvd2var(x[["U.R"]], x[["D.R"]])
  Q <- llply(seq_len(n),
             function(i) {
               F <- dlmGet(x[["mod"]], "F", i)
               V <- dlmGet(x[["mod"]], "V", i)
               F %*% R[[i]] %*% t(F) + V
             })
  if (is.null(y)) y <- x[["y"]]
  y <- as.matrix(y)
  err <- y - x[["f"]]
  laply(seq_len(n), function(i) {
    -0.5 * (log(2 * base::pi) * sum(!is.na(y[i, ]))
            + determinant(Q[[i]], logarithm = TRUE)$modulus
            + t(err[i, ]) %*% solve(Q[[i]]) %*% err[i, ])
  })
}
