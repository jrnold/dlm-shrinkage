#' @export sim_struc_break
NULL

#' Simultate from Local Level Model with Structural Breaks
#'
#' @param prob \code{numeric} (in [0, 1]) Probability of a structural break.
#' @param H \code{numeric} (> 0). Innovation standard deviation. Since
#' the observation standard deviation is fixed at 1, this is also the signal
#' to noise ratio.
#' @param T \code{numeric}. Number of observations (length of time-series) to draw.
#' @param df \code{numeric} (> 0). Degrees of freedom for the 
#' innovations distribution.
#' @param a1 \code{numeric} Value of the initial state.
#' @return \code{list} with elements
#' \describe{
#' \item{\code{a}}{\code{numeric} vector of states}
#' \item{\code{y}}{\code{numeric} vector of observations}
#' \item{\code{sbreak}}{\code{logical} vector indicating structural breaks}
#' }
#'
#' @section Details:
#'
#' Simultates from the system
#' \deqn{y \sim N(0, 1)}
#' \deqn{a_{t + 1} \sim N(0, \lambda_t H)}
#' where \code{\lambda_t} equals 1 with probabilty \code{prob}, and 0 with
#' probability \code{1 - prob}.
sim_struc_break <- function(prob = 1, H = 1, T = 101, df = Inf, a1 = 0) {
  if (prob %in% c(1, 0)) {
    sbreak <- as.logical(rep(prob, T - 1))
  } else {
    sbreak <- as.logical(rbernoulli(T - 1, prob))
  }
  sbreak <- sbreak
  nbreaks <- sum(sbreak)
  if (df < Inf) {
    break_innov <- rt(nbreaks, df) * H
  } else {
    break_innov <- rnorm(nbreaks, 0, H)
  }
  innovations <- as.numeric(sbreak)
  innovations[sbreak] <- break_innov
  a <- cumsum(c(a1, innovations))
  y <- a + rnorm(T)
  list(a = a, y = y, sbreak = sbreak)
}
