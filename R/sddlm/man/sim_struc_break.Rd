\name{sim_struc_break}
\alias{sim_struc_break}
\title{Simultate from Local Level Model with Structural Breaks}
\usage{
  sim_struc_break(prob = 1, H = 1, T = 101, df = Inf,
    a1 = 0)
}
\arguments{
  \item{prob}{\code{numeric} (in [0, 1]) Probability of a
  structural break.}

  \item{H}{\code{numeric} (> 0). Innovation standard
  deviation. Since the observation standard deviation is
  fixed at 1, this is also the signal to noise ratio.}

  \item{T}{\code{numeric}. Number of observations (length
  of time-series) to draw.}

  \item{df}{\code{numeric} (> 0). Degrees of freedom for
  the innovations distribution.}

  \item{a1}{\code{numeric} Value of the initial state.}
}
\value{
  \code{list} with elements \describe{
  \item{\code{a}}{\code{numeric} vector of states}
  \item{\code{y}}{\code{numeric} vector of observations}
  \item{\code{sbreak}}{\code{logical} vector indicating
  structural breaks} }
}
\description{
  Simultate from Local Level Model with Structural Breaks
}
\section{Details}{
  Simultates from the system \deqn{y \sim N(0, 1)}
  \deqn{a_{t + 1} \sim N(0, \lambda_t H)} where
  \eqn{\lambda_t} equals 1 with probabilty \code{prob}, and
  0 with probability \code{1 - prob}.
}

