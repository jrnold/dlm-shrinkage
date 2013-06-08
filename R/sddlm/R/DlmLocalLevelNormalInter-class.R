#' @exportClass DlmLocalLevelNormal
#' @include DLM-class.R
#' @include dlm_to_ssmodel-method.R
NULL

#' @rdname DLM-class
#' @aliases DlmLocalLevelNormal-class
setClass("DlmLocalLevelNormal", contains = "DLM")

dlm_to_ssmodel.DlmLocalLevelNormal <-
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

setMethod("dlm_to_ssmodel", "DlmLocalLevelNormal",
          dlm_to_ssmodel.DlmLocalLevelNormal)
