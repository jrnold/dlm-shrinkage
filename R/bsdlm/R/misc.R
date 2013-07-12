#' @export prgt0
#' @export prgte0
#' @export prlt0
#' @export prlte0
NULL

#' Miscellaneous functions
#'
#' @param x Numeric vector
#'
#' @section Details:
#'
#' \describe{
#' \item{\code{prgt0}}{Probability \code{x} greater than 0}
#' \item{\code{prle0}}{Probability \code{x} greater than or equal to 0}
#' \item{\code{prlt0}}{Probability \code{x} less than 0}
#' \item{\code{prlte0}}{Probability \code{x} less than or equal to 0}
#' }
prgt0 <- function(x) sum(x > 0) / length(x)

#' @rdname prgt0
prgte0 <- function(x) sum(x >= 0) / length(x)

#' @rdname prgt0
prlt0 <- function(x) sum(x < 0) / length(x)

#' @rdname prgt0
prlte0 <- function(x) sum(x <= 0) / length(x)

expand_dim <- function(x, n) {
  xdim <- length(dim(x))
  if (xdim < n) {
    if (xdim == 0) {
      array(x, c(length(x), rep(1, n - 1)))
    } else {
      array(x, c(dim(x), rep(1, n - length(dim(x)))))
    }
  } else {
    x
  }
}

#' DLM Classes
#'
#' Classes inheriting from \code{\link{McmcdbWide}} which
#' contain results of the
#' These classes do not add slots to the \code{\link{McmcdbWide}}
#' object, but exist so that methods may be written specifically for
#' different Stan models, based on implicit promises of the contents of the
#' data in those models.
#'
#' @section Classes:
#'
#' All models used in this project inherit from class \code{"DLM"}.
#'
#' \describe{
#' \item{\code{"DlmLocalLevelNormal"}}{local_level_normal}
#' }
#' @docType class
#' @rdname DLM-class
#' @aliases DLM-class
setClass("BsDlmMcmcdb", contains = "McmcdbWide")

setMethod("convergence_parameters", "BsDlmMcmcdb",
          function(object) names(mcmcdb_parameters(object)))

##' @export
dlmGet <- function(mod, i, t) {
    .dlmTv <- function(mod, x, jx, t) {
        y <- mod[[x]]
        if (!is.null(mod[[jx]])) {
            T <- nrow(mod$X)
            if (t <= T) {
                for (i in seq_len(nrow(mod[[jx]]))) {
                    for (j in seq_len(ncol(mod[[jx]]))) {
                        k <- mod[[jx]][i, j]
                        if (k > 0) {
                            y[i, j] <- mod$X[t, k]
                        }
                    }
                }
            }
            ## If t > nrow of X, then use defaults
        }
        y
    }
    switch(i,
           G = .dlmTv(mod, "GG", "JGG", t),
           F = .dlmTv(mod, "FF", "JFF", t),
           V = .dlmTv(mod, "V", "JV", t),
           W = .dlmTv(mod, "W", "JW", t),
           NULL)
}
