#' @exportMethod ssm_yrep
NULL

#' Simulate observations from the posterior distribution
#'
#' Method to simulate observations from the posterior distribution of classes
#' of models defined in this package.
#'
#' @param object An object with MCMC samples.
setGeneric("ssm_yrep",
           function(object, ...) standardGeneric("ssm_yrep"))
