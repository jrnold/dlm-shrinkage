#' @include convergence_parameters-method.R
#' @include dlm_filter-method.R
#' @exportClass BsDlmMcmcdb
NULL

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

dlm_filter.BsDlmMcmcdb <- function(object, .parallel=TRUE) {
  to_dlm <- iter_to_dlm(object)
  llply(mcmcdb_samples_iter(object),
        function(x, y) dlmFilter(y, to_dlm(x)),
        y = mcmcdb_data(object)[["y"]])
}

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

dlm_yrep <- function(m, mod) {
  m <- dropFirst(m)
  FUN <- function(i, mod, m) {
    F_i <- dlmGet(mod, "F", i)
    V_i <- dlmGet(mod, "V", i)
    mu <- F_i %*% m[i, , drop=FALSE]
    as.numeric(rmvnorm(1, mu, as.matrix(V_i)))
  }
  laply(seq_len(nrow(m)), FUN, mod = mod, m = m)
}

dlm_mu <- function(m, mod) {
  m <- dropFirst(m)
  FUN <- function(i) {
    F_i <- dlmGet(mod, "F", i)
    F_i %*% m[i, ]
  }
  laply(seq_len(nrow(m)), FUN)
}

dlm_nu <- function(y, m, mod) {
  m <- dropFirst(m)
  FUN <- function(i) {
    F_i <- dlmGet(mod, "F", i)
    if (is.null(dim(y))) y_i <- y[i]
    else y_i <- y[i, ]
    y_i - F_i %*% m[i, , drop=FALSE]
  }
  laply(seq_len(nrow(m)), FUN)
}

dlm_omega <- function(m, mod) {
  FUN <- function(i) {
    G_i <- dlmGet(mod, "G", i - 1)
    m[i, , drop=FALSE] - G_i %*% m[i - 1, , drop=FALSE]
  }
  laply(2:nrow(m), FUN)
}

setMethod("dlm_filter", "BsDlmMcmcdb", dlm_filter.BsDlmMcmcdb)
