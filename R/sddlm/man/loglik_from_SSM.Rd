\name{loglik_from_SSM}
\alias{loglik_from_SSM}
\title{Calculate observation loglikelihood from a SSModel object}
\usage{
  loglik_from_SSM(object)
}
\arguments{
  \item{object}{the object}
}
\value{
  \code{"matrix"} object with dimenions (number of
  variables, number of time periods). Log-likelihood values
  are calculated for each variable, time since KFAS uses
  the sequential filter. However, the variable level values
  of the log-likelihood are dependent on their order.
}
\description{
  Returns the observation (variables x periods) level
  log-likehood value from a \code{\link{SSModel}} object.
}

