#' @export mcmcsummary
NULL

#' MCMC Summary
#'
#' Summary of objects of class \code{DLM}, including samples from
#' the states, disturbances, and posterior predictive distribution,
#' fit and convergence criteria.
#'
#' @param object Object with MCMC samples
#' @param data \code{list} model data
#' @param .parallel \code{logical} Use parallel processing
#' @return
#' Returns a \code{"list"} with elements
#' \describe{
#' \item{\code{alpha}}{\code{matrix} Samples from the states.}
#' \item{\code{yhat}}{\code{matrix} Samples of the mean response.}
#' \item{\code{yrep}}{\code{matrix} Samples of the predicted observations.}
#' \item{\code{loglik}}{\code{matrix} Samples of the log likelihood.}
#' \item{\code{dist_obs}}{\code{matrix} Samples of the distributed observations.}
#' \item{\code{dist_state}}{\code{matrix} Samples of the distributed states.}
#' \item{\code{lppd}}{\code{matrix} log }
#' \item{\code{dic}}{Deviance information criterion.}
#' \item{\code{mse}}{Mean squared error.}
#' \item{\code{chisq}}{Chi-squared.}
#' \item{\code{rhat}}{Split Rhat values.}
#' \item{\code{ess}}{Effective sample size.}
#' }
#' @section Details:
#'
#' At the moment this is only designed for a single chain.
mcmcsummary <- function(object, data = mcmcdb_data(object), .parallel=FALSE) {
  ret <- list()

  sims <- ssm_sim(object, .parallel=.parallel)
  ret[["alpha"]] <- t(laply(sims, `[[`, i = "alpha")) # iter x states
  ret[["yhat"]] <- t(laply(sims, `[[`, i = "yhat"))
  ret[["yrep"]] <- t(laply(sims, `[[`, i = "yrep"))
  ret[["loglik"]] <- t(laply(sims, `[[`, i = "loglik"))
  ret[["dist_obs"]] <- t(laply(sims, `[[`, i = "dist_obs"))
  ret[["dist_state"]] <- t(laply(sims, `[[`, i = "dist_state"))


  # Fit
  y <- mcmcdb_data(object)[["y"]]
  ret[["lppd"]] <- log(apply(exp(ret[["loglik"]]), 1, mean))
  ret[["waic"]] <- waic(ret[["loglik"]])
  ret[["dic"]] <- dic(-2 * apply(ret[["loglik"]], 2, sum))
  ret[["mse"]] <- discrepancy(y, ret[["yrep"]], "mse")
  ret[["chisq"]] <- discrepancy(y, ret[["yrep"]], "chisq")

  # Convergence
  pars <- dlm_parameters(object)
  ret[["rhat"]] <- mcmcdb_samples_flatpars(object, parameters = pars,
                                           "rhat_split")
  ret[["ess"]] <- mcmcdb_samples_flatpars(object, parameters = pars,
                                          "ess")
  ret
}

