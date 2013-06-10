#' @exportClass DlmSplineHs
#' @include DLM-class.R
#' @include dlm_to_ssmodel-method.R
NULL

#' @rdname DLM-class
#' @aliases DlmSplineHs-class
setClass("DlmSplineHs", contains = "DLM")

dlm_to_ssmodel.DlmSplineHs <-
  function(object) {
    data <- mcmcdb_data(object)
    n <- length(data$y)
    T <- array(rep(c(1, 0, 1, 1), n), c(2, 2, n))
    T[1, 2, ] <- data$ydiff
    .local <- function(iter) {
      Q <- mlply(data.frame(ydiff = data$ydiff,
                            lambda = as.numeric(iter$lambda)),
                 function(ydiff, lambda, tau) {
                   Q <- matrix(0, 2, 2)
                   Q[1, 1] <- ydiff^3 * (1/3)
                   Q[1, 2] <- Q[2, 1] <- ydiff^2 * 0.5
                   Q[2, 2] <- ydiff
                   Q * ydiff * tau^2 * lambda^2
                 }, tau = iter[["tau"]])
      Q <- simplify2array(Q)
      SSModel(data[["y"]],
              Z = matrix(c(1, 0), 1, 2),
              H = matrix(1),
              T = T,
              Q = Q,
              a1 = data$a1,
              P1 = data$P1)
    }
  }

setMethod("dlm_to_ssmodel", "DlmSplineHs", dlm_to_ssmodel.DlmSplineHs)
