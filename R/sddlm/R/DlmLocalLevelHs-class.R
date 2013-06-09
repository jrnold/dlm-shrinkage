#' @include DLM-class.R
#' @include dlm_to_ssmodel-method.R
#' @exportClass DlmLocalLevelHs
NULL

#' @rdname DLM-class
#' @aliases DlmLocalLevelHs-class
setClass("DlmLocalLevelHs", contains = "DLM")

dlm_to_ssmodel.DlmLocalLevelHs <-
  function(object) {
    data <- mcmcdb_data(object)
    function(iter) {
      SSModel(data$y,
              Z = matrix(1),
              H = iter$H,
              T = matrix(1),
              Q = array(iter$Q, c(1, 1, length(iter$Q))),
              a1 = data$a1,
              P1 = data$P1)
    }
  }

setMethod("dlm_to_ssmodel", "DlmLocalLevelHs",
          dlm_to_ssmodel.DlmLocalLevelHs)
