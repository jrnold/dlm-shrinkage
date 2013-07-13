\name{dlm_stats}
\alias{dlm_stats}
\title{Calculate misc stats for a DLM}
\usage{
  dlm_stats(y, mod)
}
\arguments{
  \item{y:}{the data. ‘y’ can be a vector, a matrix, a
  univariate or multivariate time series.}

  \item{mod:}{an object of class ‘dlm’}

  \item{y}{}
}
\value{
  A \code{list} with elements \describe{ \item{filter}{An
  object of class \code{\linkS4class{dlmFiltered}}}
  \item{smooth}{The output of \code{\link{dlmSmooth}}}
  \item{yrep}{The output of \code{\link{dlmYrep}}}
  \item{nu}{The output of \code{\link{dlmNu}}}
  \item{omega}{The output of \code{\link{dlmOmega}}}
  \item{loglik}{The output of \code{\link{dlmLogLikObs}}} }
}
\description{
  Calculate misc stats for a DLM
}

