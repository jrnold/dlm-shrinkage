#' @export loglik_from_SSM
NULL

#' Calculate observation loglikelihood from a SSModel object
#'
#' Returns the observation (variables x periods) level log-likehood
#' value from a \code{\link{SSModel}} object.
#'
#' @param object the object
#' @return \code{"matrix"} object with dimenions (number of variables, number of time periods).
#' Log-likelihood values are calculated for each variable, time since KFAS uses the sequential
#' filter. However, the variable level values of the log-likelihood are dependent on their order.
loglik_from_SSM <- function(object) {
  filt <- KFS(object, smoothing = "none")
  dnorm(filt$v, 0, sqrt(filt$F), log=TRUE)
}
