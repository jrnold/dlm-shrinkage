\name{discrepancy_mse}
\alias{discrepancy_mse}
\title{Discrepancy functions}
\usage{
  discrepancy_mse(y, yrep)
}
\arguments{
  \item{y}{vector of true data}

  \item{yrep}{matrix in which rows are observations and
  columns are samples.}

  \item{dist}{Distance function to use; which must be a
  function named \code{discrepancy_{dist}}.}
}
\value{
  \code{"numeric"} vector with the discrepancy score.
}
\description{
  Functions to calculate discrepancy between "true" data
  and posterior predictive distributions
}
\section{Details}{
  \description{ \item{\code{discrepancy_mse}}{Mean squared
  error} \item{\code{discrepancy_chisq}}{Chi squared
  distance} }
}

