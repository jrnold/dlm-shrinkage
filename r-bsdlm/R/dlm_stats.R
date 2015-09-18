#' Calculate misc stats for a DLM
#'
#' @param y The data. 'y' can be a vector, a matrix, a univariate or multivariate time series.
#' @param mod An object of class 'dlm'
#' @return A \code{list} with elements
#' \describe{
#' \item{filter}{An object of class \code{\link[dlm:dlmFilter]{dlmFiltered}}}
#' \item{smooth}{The output of \code{\link[dlm]{dlmSmooth}}}
#' \item{yrep}{The output of \code{\link[dlmextras]{dlmYrep}} using smoothed draws.}
#' \item{nu}{The output of \code{\link[dlmextras]{dlmNu}}}
#' \item{omega}{The output of \code{\link[dlmextras]{dlmOmega}}}
#' \item{loglik}{The output of \code{\link[dlmextras]{dlmLogLikObs}}}
#' }
#' @export dlm_stats
dlm_stats <- function(y, mod) {
  filter <- dlmFilter(y, mod)
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
