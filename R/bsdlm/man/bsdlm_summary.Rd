\name{bsdlm_summary}
\alias{bsdlm_summary}
\title{DLM Summary values for a Bsdlm Object}
\usage{
  bsdlm_summary(object, chain_id = NULL, iter = NULL, ...)
}
\arguments{
  \item{object}{An object of class \code{BsDlmMcmcdb}.}

  \item{chain_id}{Chain ids of iterations to use.}

  \item{iter}{Iteration numbers of iterations to use.}

  \item{...}{Options passed to \code{\link{laply}}.}
}
\value{
  \code{list} with the results of \code{\link{dlm_stats}}
  for each iteration of \code{object}
}
\description{
  DLM Summary values for a Bsdlm Object
}

