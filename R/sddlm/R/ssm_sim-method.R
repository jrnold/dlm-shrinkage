#' @exportMethod ssm_sim
NULL

#' Simulate states from a model
#'
#' @param object An object containing MCMC samples from a state space model.
#' @param data \code{list} Additional data needed by the method, usually
#' the observations.
#'
#' @return An object of class \code{"array"}.
setGeneric("ssm_sim",
           function(object, ...) {
             standardGeneric("ssm_sim")
           })
