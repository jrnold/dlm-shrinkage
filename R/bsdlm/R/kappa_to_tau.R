#' Solve for tau associated with a mean kappa.
#'
#' Given a mean shrinkage parameter, solve for the implied global
#' variance component in a global-local mixture of normal distribution.
#' \deqn{E \kappa = \int \frac{1}{1 + \tau^2 \lambda^2} d \lambda^2}
#' 
#' @param kappa Mean shrinkage parameter
#' @param f Function of a single parameter that draws from
#' \eqn{lambda^2}.
#' @param tau Initial value of tau.
#' @param n Number of values 
#' @param ... Passed to \code{\link{optim}}.
#'
#' @return \code{"numeric"} Value of tau.
#'
#'
#' @export
kappa_to_tau <- function(kappa, f, n = 10000, tau=1, ...) {
  lambda2 <- f(n)
  FUN <- function(tau) {
    abs(kappa - mean(1 / (1 + tau^2 * lambda2)))
  }
  optim(tau, FUN, ...)
}
