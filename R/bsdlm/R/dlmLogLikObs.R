#' DLM Log Likelihood
#'
#' Log likelihood of a dynamic linear model, including the
#' constant.
#'
#' @param y observed data
#' @param mod An object of class \code{mod}.
#' @export
dlmLogLikObs <- function(filter, y = NULL) {
  n <- nrow(as.matrix(filter$f))
  R <- dlmSvd2var(filter[["U.R"]], filter[["D.R"]])
  Q <- llply(seq_len(n),
             function(i) {
               F <- dlmGet(filter[["mod"]], "F", i)
               V <- dlmGet(filter[["mod"]], "V", i)
               F %*% R[[i]] %*% t(F) + V
             })
  if (is.null(y)) y <- filter[["y"]]
  y <- as.matrix(y)
  err <- y - filter[["f"]]
  laply(seq_len(n), function(i) {
    -0.5 * (log(2 * base::pi) * sum(!is.na(y[i, ]))
            + determinant(Q[[i]], logarithm = TRUE)$modulus
            + t(err[i, ]) %*% solve(Q[[i]]) %*% err[i, ])
  })
}
