#' @export bsdlm_summary
NULL

#' DLM Summary values for a Bsdlm Object
#'
#' @param object An object of class \code{BsDlmMcmcdb}.
#' @param chain_id Chain ids of iterations to use.
#' @param iter Iteration numbers of iterations to use.
#' @param ... Options passed to \code{\link{laply}}.
#' @return \code{list} with the results of \code{\link{dlm_stats}} for each iteration
#' of \code{object}
bsdlm_summary <- function(object, chain_id = NULL, iter = NULL, ...) {
  ret <- list()
  to_dlm <- iter_to_dlm(object)
  data <- mcmcdb_data(object)
  FUN <- function(iter, to_dlm, y) {
    dlm_stats(y, to_dlm(iter))
  }
  ret1 <- mcmcdb_samples_iter(object, iter = iter, chain_id = chain_id,
               FUN = FUN, to_dlm = to_dlm, y = t(data[["y"]]),
                              ...)
  for (i in names(ret1[[1]])) {
    ret[[i]] <- llply(ret1, function(x) x[[i]])
  }
  loglik <- simplify2array(ret[["loglik"]]) # rows = obs, cols = iters
  yrep <- simplify2array(ret[["yrep"]]) # rows = obs, cols = iters
  ret[["lppd"]] <- log(apply(exp(loglik), 1, mean))
  ret[["waic"]] <- waic(loglik)
  ret[["dic"]] <- dic(-2 * apply(loglik, 2, sum))
  ret[["mse"]] <- discrepancy(y, yrep, "mse")
  ret[["chisq"]] <- discrepancy(y, yrep, "chisq")

  pars <- convergence_parameters(object)
  ret[["rhat"]] <- mcmcdb_samples_flatpars(object, parameters = pars,
                                           "rhat_split")
  ret[["ess"]] <- mcmcdb_samples_flatpars(object, parameters = pars,
                                          "ess")
  ## return
  ret
}

