#' The Horseshoe Distribution
#'
#' Density function and random generation for the horseshoe distribution.
#'
#' @param x \code{numeric} vector of quantiles.
#' @param n \code{integer} number of observations.
#' @param scale \code{numeric}. Scale parameter, greater than zero.
#' @param location \code{numeric}. Location parameter.
#' @return \code{numeric} vector of density values.
#'
#' @section Details:
#'
#' There is no exact analytical form of the horseshoe distribution.
#' It is defined as a scale mixture of normal distributions.
#'
#' \deqn{
#' p(x) \sim \mathcal{N}(0, \lambda^2)
#' }{p(x | lambda, tau) ~ N(0, \lambda^2)}
#' \deqn{
#' \lambda \sim \mathcal{C}^{+}(0, \tau)
#' }{lambda ~ C+(0, tau)}
#'where \eqn{C^{+}(0, s)}{C+(0, s)} is the half-Cauchy distribution with support on the positive real numbers and
#' scale \eqn{s}.
#'
#' However, Theorem 1 of Carvallo et al. (2010) provide bounds on the univariate
#' density function.  For \eqn{x \neq 0},
#' \deqn{
#' \frac{K}{2} \log \left(1 + \frac{4}{x^2} \right) < p(x) < K \log \left( 1 + \frac{2}{x^2}\right)
#' }{(K / 2) * log(1 + 4 / x^2) < p(x) < K * log(1 + 2 / x^2)}
#' where \eqn{K = 1 / \sqrt{2 \pi^3}}{K = 1 / sqrt(2 * pi^3)}.
#'
#' @references
#'
#' Carvalho, Carlos M., Nicholas G. Polson, and James G. Scott (2010). \dQuote{The horseshoe estimator for sparse
#' signals}. \emph{Biometrika}, \strong{97.2}, pp. 465-480. \url{http://biomet.oxfordjournals.org/content/97/2/465.abstract}.
#'
#' Carvalho, Carlos M., Nicholas G. Polson, and James G. Scott (2009). \dQuote{Handling Sparsity via the Horseshoe}.
#' \emph{Journal of Machine Learning and Research: Workshop and Conference Proceedings} \strong{5}, pp. 73-80.
#' @rdname horseshoe
#' @export
#' @examples
#' x <- seq(-4, 4, by = 0.01)
#' y <- dhorseshoe(x)
#' plot(x, y, ylim= c(0, 1), type = "l")
#' z <- rhorseshoe(5000)
#' plot(density(z), xlim = c(-4, 4))
dhorseshoe <- function(x, location = 0, scale = 1) {
  x <- (x - location) / scale
  K <- 1 / sqrt(2 * pi ^ 3)
  lb <- (K / 2) * log(1 + 4 / x ^ 2)
  ub <- K * log(1 + 2 / x ^ 2)
  0.5 * (lb + ub)
}

#' @rdname horseshoe
#' @export
rhorseshoe <- function(n, location = 0, scale = 1) {
  lambda <- abs(rcauchy(n, scale = scale))
  rnorm(n, location, lambda)
}

#' The Horseshoe+ Distribution
#'
#' Density function and random generation for the horseshoe+ prior distribution.
#'
#' @param x \code{numeric} vector of quantiles.
#' @param n \code{integer} number of observations.
#' @param scale \code{numeric}. Scale parameter, greater than zero.
#' @param location \code{numeric}. Location parameter.
#' @return \code{numeric} vector of density values.
#'
#' @section Details:
#'
#' There is no exact analytical form of the horseshoe+ prior distribution.
#' It is defined as a scale mixture of normal distributions:
#' \deqn{
#' p(x | \lambda, \tau, \eta) \sim \mathcal{N}(0, \lambda^2)
#' }{p(x | lambda, tau, eta) ~ N(0, lambda^2)}
#' \deqn{
#' \lambda \sim \mathcal{C}^{+}(0, \tau \eta)
#' }{lambda ~ C^+(0, tau eta)}
#' \deqn{
#' \eta \sim \mathcal{C}^+(0, 1)
#' }{eta ~ C^+(0, 1)}
#' and \eqn{C^{+}(0, s)} is the half-Cauchy distribution with support on the positive real numbers and scale \eqn{s}.
#'
#' However, Theorem 2 of Bhadra et al. (2015) provide bounds on the univariate  density function.  For \eqn{x \neq 0},
#' \deqn{
#' \frac{1}{\pi^2 \sqrt{2 \pi}} \log \left(1 + \frac{4}{x^2} \right) < p(x) < \frac{1}{\pi^2 |x|}
#' }{1 / (pi^2 * sqrt(2 * pi)) log(1 + 4 / x^2) < p(x) < 1 / (pi^2 * |x|)}
#'
#' @references
#'
#' Bhadra, Anindya and Datta, Jyotishka and Polson, Nicholas G. and Willard, Brandon. (2015). \dQuote{The Horseshoe+ Estimator of Ultra-Sparse Signals}.
#' arXiv:1502.00560 [math.ST]. \url{http://arxiv.org/abs/1502.00560v2}.
#'
#' @rdname horseshoeplus
#' @export
#' @examples
#' x <- seq(-4, 4, by = 0.01)
#' y <- dhorseshoeplus(x)
#' plot(x, y, ylim= c(0, 1), type = "l")
#' z <- rhorseshoeplus(5000)
#' plot(density(z), xlim = c(-4, 4))
dhorseshoeplus <- function(x, location = 0, scale = 1) {
  x <- (x - location) / scale
  lb <- 1 / (base::pi ^ 2 * sqrt(2 * base::pi)) * log(1 + 4 / x ^ 2)
  ub <- 1 / (base::pi ^ 2 * abs(x))
  0.5 * (lb + ub)
}

#' @rdname horseshoeplus
#' @export
rhorseshoeplus <- function(n, location = 0, scale = 1) {
  eta <- abs(rcauchy(n))
  lambda <- abs(rcauchy(n, scale = scale * eta))
  rnorm(n, location, lambda)
}
