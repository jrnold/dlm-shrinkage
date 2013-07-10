#' @include convergence_parameters-method.R
#' @include dlm_filter-method.R
#' @exportClass BsDlmMcmcdb
NULL


dlm_filter.BsDlmMcmcdb <- function(object, .parallel=TRUE) {
  to_dlm <- iter_to_dlm(object)
  llply(mcmcdb_samples_iter(object),
        function(x, y) dlmFilter(y, to_dlm(x)),
        y = mcmcdb_data(object)[["y"]])
}

setMethod("dlm_filter", "BsDlmMcmcdb", dlm_filter.BsDlmMcmcdb)
