#' @exportClass DlmLocalLevelNormal
#' @include DLM-class.R
#' @include ssm_sim-method.R
#' @include ssm_loglik-method.R
#' @include ssm_sim-method.R
NULL

#' @rdname DLM-class
#' @aliases DlmLocalLevelNormal-class
setClass("DlmLocalLevelNormal", contains = "DLM")
