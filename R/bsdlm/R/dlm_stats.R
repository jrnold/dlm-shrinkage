#' @include dlmYrep.R
#' @include dlmMu.R
#' @include dlmNu.R
#' @include dlmOmega.R
#' @include dlmLogLikObs.R
#' @export dlm_stats
NULL

#' Calculate misc stats for a DLM
#'
#' @param y: the data. ‘y’ can be a vector, a matrix, a univariate or multivariate time series.
#' @param mod: an object of class ‘dlm’
#' @param y 
#' @return A \code{list} with elements
#' \describe{
#' \item{filter}{An object of class \code{\linkS4class{dlmFiltered}}}
#' \item{smooth}{The output of \code{\link{dlmSmooth}}}
#' \item{yrep}{The output of \code{\link{dlmYrep}} using smoothed draws.}
#' \item{nu}{The output of \code{\link{dlmNu}}}
#' \item{omega}{The output of \code{\link{dlmOmega}}}
#' \item{loglik}{The output of \code{\link{dlmLogLikObs}}}
#' }
dlm_stats <- function(y, mod) {
  filter <- dlmFilter(y, mod)
#  smooth <- dlmSmooth(filter)
  sample <- dlmBSample(filter)
  
  yrep <- dlmYrep(as.matrix(dropFirst(sample)), mod)
  mu <- dlmMu(as.matrix(dropFirst(sample)), mod)
  nu <- dlmNu(y, as.matrix(dropFirst(sample)), mod)
  omega <- dlmOmega(as.matrix(dropFirst(sample)), mod)
  ll <- dlmLogLikObs(filter)
  list(sample = sample,
       yrep = yrep, mu = mu,
       nu = nu, omega = omega, loglik = ll)
}
