#' @export prgt0
#' @export prgte0
#' @export prlt0
#' @export prlte0
NULL

#' Miscellaneous functions
#'
#' @param x Numeric vector
#'
#' @section Details:
#'
#' \describe{
#' \item{\code{prgt0}}{Probability \code{x} greater than 0}
#' \item{\code{prle0}}{Probability \code{x} greater than or equal to 0}
#' \item{\code{prlt0}}{Probability \code{x} less than 0}
#' \item{\code{prlte0}}{Probability \code{x} less than or equal to 0}
#' }
prgt0 <- function(x) sum(x > 0) / length(x)

#' @rdname prgt0
prgte0 <- function(x) sum(x >= 0) / length(x)

#' @rdname prgt0
prlt0 <- function(x) sum(x < 0) / length(x)

#' @rdname prgt0
prlte0 <- function(x) sum(x <= 0) / length(x)

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
setClass("BsDlmMcmcdb", contains = "McmcdbWide")

setMethod("convergence_parameters", "BsDlmMcmcdb",
          function(object) names(mcmcdb_parameters(object)))

