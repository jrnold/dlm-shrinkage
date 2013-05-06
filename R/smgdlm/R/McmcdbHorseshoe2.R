#' @include smgdlm-package.R
#' @exportClass McmcdbHorseshoe2
NULL

setClass("McmcdbHorseshoe2", contains = "McmcdbWide")

setMethod("summary", "McmcdbHorseshoe2", summary.McmcdbHorseshoe)
