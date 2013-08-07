#' @include utilities.R
NULL

#' Get specific component of a dlm object
#'
#' Get specific component of a dlm object for a given time.
#' @param mod An object of class \code{"dlm"}.
#' @param i Component name, one of \code{"F"}, \code{"G"}, \code{"V"}, or \code{"W"}.
#' @param t \code{"integer"}. The time period to return. For time-invariant components, this
#' will always be the same value.
#' @return \code{matrix}
#' @export
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
