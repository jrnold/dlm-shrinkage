#' @exportClass DlmLocalLevelNormal
#' @include DLM-class.R
#' @include dlm_to_ssmodel-method.R
#' @include dlm_parameters-method.R
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
              H = iter$H,
              T = matrix(1),
              Q = iter$Q,
              a1 = data$a1,
              P1 = data$P1)
    }
  }

setMethod("dlm_to_ssmodel", "DlmLocalLevelNormal",
          dlm_to_ssmodel.DlmLocalLevelNormal)

setMethod("dlm_parameters", "DlmLocalLevelNormal",
          function(object) names(mcmcdb_parameters(object)))
