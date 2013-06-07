#' @include dlm_parameters-method.R
#' @exportClass DLM
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
setClass("DLM", contains = "McmcdbWide")

setMethod("dlm_parameters", "DlmLocalLevelNormalReg",
          function(object) names(mcmcdb_parameters(object)))

