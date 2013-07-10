\name{mcmcsummary}
\alias{mcmcsummary}
\title{MCMC Summary}
\usage{
  mcmcsummary(object, data = mcmcdb_data(object),
    parallel = FALSE)
}
\arguments{
  \item{object}{Object with MCMC samples}

  \item{data}{\code{list} model data}

  \item{.parallel}{\code{logical} Use parallel processing}
}
\value{
  Returns a \code{"list"} with elements \describe{
  \item{\code{alpha}}{\code{matrix} Samples from the
  states.} \item{\code{yhat}}{\code{matrix} Samples of the
  mean response.} \item{\code{yrep}}{\code{matrix} Samples
  of the predicted observations.}
  \item{\code{loglik}}{\code{matrix} Samples of the log
  likelihood.} \item{\code{dist_obs}}{\code{matrix} Samples
  of the distributed observations.}
  \item{\code{dist_state}}{\code{matrix} Samples of the
  distributed states.} \item{\code{lppd}}{\code{matrix} log
  } \item{\code{dic}}{Deviance information criterion.}
  \item{\code{mse}}{Mean squared error.}
  \item{\code{chisq}}{Chi-squared.}
  \item{\code{rhat}}{Split Rhat values.}
  \item{\code{ess}}{Effective sample size.} }
}
\description{
  Summary of objects of class \code{DLM}, including samples
  from the states, disturbances, and posterior predictive
  distribution, fit and convergence criteria.
}
\section{Details}{
  At the moment this is only designed for a single chain.
}

