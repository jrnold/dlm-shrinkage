\name{dhp}
\alias{dhp}
\alias{rhp}
\title{The Horseshoe Prior Distribution}
\usage{
  dhp(x, scale = 1, mu = 0)

  rhp(n, scale = 1, mu = 0)
}
\arguments{
  \item{x}{\code{numeric} vector of quantiles.}

  \item{n}{\code{integer} number of observations.}

  \item{scale}{\code{numeric}. Scale parameter, greater
  than zero.}

  \item{mu}{\code{numeric}. Location parameter.}
}
\value{
  \code{numeric} vector of density values.
}
\description{
  Density function and random generation for the horseshoe
  prior distribution.
}
\section{Details}{
  There is no exact analytical form of the horseshoe prior
  distribution. It is defined as a scale mixture of normal
  distributions.

  \deqn{ p(x) \sim N(0, \lambda \tau) } where, \deqn{
  \lambda \sim C^{+}(0, 1) } and \eqn{C^{+}(0, s)} is the
  half-Cauchy distribution with support on the positive
  real numbers and scale \eqn{s}.

  However, Theorem 1 of Carvallo et al. (2010) provide
  bounds on the univariate density function.  For \eqn{x
  \neq 0}, \deqn{\frac{K}{2} \log \left(1 + \frac{4}{x^2}
  \right) < p(x) < K \log \left( 1 + \frac{2}{x^2}\right)}
  where \eqn{k = 1 / \sqrt{2 \pi^3}}.
}
\references{
  Carvalho, Carlos M., Nicholas G. Polson, and James G.
  Scott (2010). "The horseshoe estimator for sparse
  signals". Biometrika, 97.2, pp. 465-480.
  \url{http://biomet.oxfordjournals.org/content/97/2/465.abstract}.

  Carvalho, Carlos M., Nicholas G. Polson, and James G.
  Scott (2009). "Handling Sparsity via the Horseshoe".
  Journal of Machine Learning and Research: Workshop and
  Conference Proceedings 5, pp. 73-80.
}

