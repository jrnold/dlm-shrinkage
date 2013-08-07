\name{dlmGet}
\alias{dlmGet}
\title{Get specific component of a dlm object}
\usage{
  dlmGet(mod, i, t)
}
\arguments{
  \item{mod}{An object of class \code{"dlm"}.}

  \item{i}{Component name, one of \code{"F"}, \code{"G"},
  \code{"V"}, or \code{"W"}.}

  \item{t}{\code{"integer"}. The time period to return. For
  time-invariant components, this will always be the same
  value.}
}
\value{
  \code{matrix}
}
\description{
  Get specific component of a dlm object for a given time.
}

