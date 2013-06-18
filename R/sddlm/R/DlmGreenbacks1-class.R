#' @include DLM-class.R
#' @include dlm_to_ssmodel-method.R
#' @exportClass DlmGreenbacks1
NULL

#' @rdname DLM-class
#' @aliases DlmGreenbacks1-class
setClass("DlmGreenbacks1", contains = "DLM")

dlm_to_ssmodel.DlmGreenbacks1 <-
  function(object) {
    data <- mcmcdb_data(object)
    function(iter) {
      SSModel(data$y,
              Z = matrix(1),
              H = array(iter$H, c(1, 1, length(iter$H))),
              T = matrix(1),
              Q = array(iter$Q, c(1, 1, length(iter$Q))),
              a1 = data$a1,
              P1 = data$P1)
    }
  }

setMethod("dlm_to_ssmodel", "DlmGreenbacks1",
          dlm_to_ssmodel.DlmGreenbacks1)
