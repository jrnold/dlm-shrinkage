#' Discrepancy functions
#'
#' Functions to calculate discrepancy between "true" data and posterior
#' predictive distributions
#'
#' @param y vector of true data
#' @param yrep matrix in which rows are observations and columns are samples.
#' @param dist Distance function to use; which must be a function named \code{discrepancy_{dist}}.
#' @return \code{"numeric"} vector with the discrepancy score.
#'
#' @section Details:
#'
#' \describe{
#' \item{\code{discrepancy_mse}}{Mean squared error}
#' \item{\code{discrepancy_chisq}}{Chi squared distance}
#' }
#' @export
discrepancy <- function(y, yrep, dist = "chisq") {
  f <- get(sprintf("discrepancy_%s", dist))
  f(y, yrep)
}

#' @rdname discrepancy
#' @export
discrepancy_mse <- function(y, yrep) {
  ey <- apply(yrep, 1, mean)
  mean((y - ey)^2)
}

#' @rdname discrepancy
#' @export
discrepancy_chisq <- function(y, yrep) {
  ey <- apply(yrep, 1, mean)
  vy <- apply(yrep, 1, var)
  sum((y - ey)^2 / vy)
}

