#' @exportClass DlmSpline
#' @include DLM-class.R
#' @include dlm_to_ssmodel-method.R
NULL

#' @rdname DLM-class
#' @aliases DlmSpline-class
setClass("DlmSpline", contains = "DLM")

dlm_to_ssmodel.DlmSpline <-
  function(object) {
    data <- mcmcdb_data(object)
    n <- length(data$y)
    T <- array(rep(c(1, 0, 1, 1), n), c(2, 2, n))
    T[1, 2, ] <- data$ydiff
    Q <- array(0, c(2, 2, n))
    Q[1, 1, ] <- data$ydiff^3 * (1/3)
    Q[1, 2, ] <- Q[2, 1, ] <- data$ydiff^2 * 0.5
    Q[2, 2, ] <- data$ydiff
    function(iter) {
      SSModel(data[["y"]],
              Z = matrix(c(1, 0), 1, 2),
              H = matrix(1),
              T = T,
              Q = Q * iter[["tau"]]^2,
              a1 = data$a1,
              P1 = data$P1)
    }
  }

setMethod("dlm_to_ssmodel", "DlmSpline", dlm_to_ssmodel.DlmSpline)
