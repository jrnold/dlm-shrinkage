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
    function(iter) {
      SSModel(data$y,
              Z = matrix(c(1, 0), 1, 2),
              H = matrix(1),
              T = array(length(iter$T), c(1, 1, length(iter$T))),
              Q = array(length(iter$Q), c(1, 1, length(iter$Q))),
              a1 = data$a1,
              P1 = data$P1)
    }
  }

setMethod("dlm_to_ssmodel", "DlmSpline", dlm_to_ssmodel.DlmSpline)
