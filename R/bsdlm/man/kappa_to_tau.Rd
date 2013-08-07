\name{kappa_to_tau}
\alias{kappa_to_tau}
\title{Solve for tau associated with a mean kappa.}
\usage{
  kappa_to_tau(kappa, f, n = 10000, tau = 1, ...)
}
\arguments{
  \item{kappa}{Mean shrinkage parameter}

  \item{f}{Function of a single parameter that draws from
  \eqn{lambda^2}.}

  \item{tau}{Initial value of tau.}

  \item{n}{Number of values}

  \item{...}{Passed to \code{\link{optim}}.}
}
\value{
  \code{"numeric"} Value of tau.
}
\description{
  Solve for tau associated with a mean kappa.
}
\section{Given a mean shrinkage parameter, solve for the implied global
variance component in a global-local mixture of normal distribution.
\deqn{E \kappa = \int \frac{1}{1 + \tau^2 \lambda^2} d \lambda^2}}{

}

