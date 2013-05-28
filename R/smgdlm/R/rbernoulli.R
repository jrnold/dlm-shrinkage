#' @export rbernoulli
NULL

#' Bernoulli distribution
#'
#' Random generation for the bernoulli distribution.
#' 
#' @param n number of observations
#' @param prob probability of success on each trial.
#' @return \code{numeric} vector of samples from the distribution.
rbernoulli <- function(n, prob) rbinom(n, 1, prob)
