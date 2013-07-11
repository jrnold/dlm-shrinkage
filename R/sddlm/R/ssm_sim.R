#' @include dlm_filter-method.R
#' @export ssm_sim
NULL

dlm_yrep <- function(m, mod) {
  m <- dropFirst(m)
  FUN <- function(i, mod, m) {
    F_i <- dlmGet(mod, "F", i)
    V_i <- dlmGet(mod, "V", i)
    mu <- F_i %*% m[i, , drop=FALSE]
    as.numeric(rmvnorm(1, mu, as.matrix(V_i)))
  }
  laply(seq_len(nrow(m)), FUN, mod = mod, m = m)
}

dlm_mu <- function(m, mod) {
  m <- dropFirst(m)
  FUN <- function(i) {
    F_i <- dlmGet(mod, "F", i)
    F_i %*% m[i, ]
  }
  laply(seq_len(nrow(m)), FUN)
}

dlm_nu <- function(y, m, mod) {
  m <- dropFirst(m)
  FUN <- function(i) {
    F_i <- dlmGet(mod, "F", i)
    if (is.null(dim(y))) y_i <- y[i]
    else y_i <- y[i, ]
    y_i - F_i %*% m[i, , drop=FALSE]
  }
  laply(seq_len(nrow(m)), FUN)
}

dlm_omega <- function(m, mod) {
  FUN <- function(i) {
    G_i <- dlmGet(mod, "G", i - 1)
    m[i, , drop=FALSE] - G_i %*% m[i - 1, , drop=FALSE]
  }
  laply(2:nrow(m), FUN)
}

ssm_sim <- function(object, data = mcmcdb_data(object), parallel=FALSE, chain_id = NULL, iter = NULL) {
  FUN <- function(iter, data, to_dlm) {
    states <- dlm_filter(iter)
    dim(alpha) <- dim(alpha)[1:2]
    yrep <- yrep_from_ssm(ssmodel, alpha)
    yhat <- yhat_from_ssm(ssmodel, alpha)
    omega <- dist_obs_from_ssm(ssmodel, alpha)
    nu <- dist_state_from_ssm(ssmodel, alpha)
    loglik <- loglik_from_SSM(ssmodel)
    list(alpha = alpha, yhat = yhat, yrep = yrep, loglik = loglik,
         dist_state = eta, dist_obs = epsilon)
  }
  mcmcdb_samples_iter(object, FUN,
                      data = mcmcdb_data(object),
                      to_ssm = iter_to_dlm(object),
                      .parallel = parallel,
                      .paropts = list(.packages = c("sddlm")),
                      chain_id = chain_id, iter = iter)
}
