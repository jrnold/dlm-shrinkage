\name{crosszero}
\alias{crosszero}
\title{Interval includes zero}
\usage{
  crosszero(x, y, include = TRUE)
}
\arguments{
  \item{x}{interval endpoints}

  \item{y}{interval endpoints}

  \item{include}{\code{logical}. If \code{TRUE} then
  returns \code{TRUE} if 0 is one of the endpoints.}
}
\value{
  \code{logical} vector indicating whether the intervals
  [\code{x}, code{y}], include or cross zero.
}
\description{
  Check whether an interval includes zero.
}

