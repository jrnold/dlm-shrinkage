#' @include dlm_to_ssmodel-method.R
#' @export ssm_sim
NULL

ssmodel_array2list <- function(x, n) {
  if (dim(x)[3] > 1) {
    llply(seq_len(n),
          function(i) {
            xi <- x[ , , i]
            dim(xi) <- dim(xi)[1:2]
            xi
          })
  } else {
    replicate(n, {dim(x) <- dim(x)[1:2]; x}, simplify=FALSE)
  }
}

# alpha: m x 1 x n
# Z: p x m x n
# H: p x p x n
yhat_from_ssm <- function(object, alpha) {
  Z <- ssmodel_array2list(object$Z, object$n)
  FUN <- function(i) {
    Z[[i]] %*% alpha[ , i, drop=FALSE]
  }
  laply(seq_len(dim(alpha)[2]), .fun = FUN, .drop=FALSE)
}

# return: 
dist_obs_from_ssm <- function(object, alpha) {
  Z <- ssmodel_array2list(object$Z, object$n)
  y <- as.matrix(object$y)
  FUN <- function(i) {
    y[i, , drop=FALSE] - Z[[i]] %*% alpha[ , i, drop=FALSE]
  }
  laply(seq_len(dim(alpha)[2]), .fun = FUN, .drop=FALSE)
}

dist_state_from_ssm <- function(object, alpha) {
  T <- ssmodel_array2list(object$T, object$n)
  lalpha <- cbind(matrix(object$a1), alpha[ , 1:(ncol(alpha) - 1), drop=FALSE])
  FUN <- function(i) {
    alpha[ , i, drop=FALSE] - T[[i]] %*% lalpha[ , i, drop=FALSE]
  }
  laply(seq_len(dim(alpha)[2]), .fun = FUN, .drop=FALSE)
}


ssm_sim <- function(object, data = mcmcdb_data(object), parallel=FALSE, chain_id = NULL, iter = NULL) {
  FUN <- function(iter, data, to_ssm) {
    ssmodel <- to_ssm(iter)
    alpha <- simulateSSM(ssmodel, "states")[["states"]]
    dim(alpha) <- dim(alpha)[1:2]
    yrep <- yrep_from_ssm(ssmodel, alpha)
    yhat <- yhat_from_ssm(ssmodel, alpha)
    epsilon <- dist_obs_from_ssm(ssmodel, alpha)
    eta <- dist_state_from_ssm(ssmodel, alpha)
    loglik <- loglik_from_SSM(ssmodel)
    list(alpha = alpha, yhat = yhat, yrep = yrep, loglik = loglik,
         dist_state = eta, dist_obs = epsilon)
  }
  mcmcdb_samples_iter(object, FUN,
                      data = mcmcdb_data(object),
                      to_ssm = dlm_to_ssmodel(object),
                      .parallel = parallel,
                      .paropts = list(.packages = c("sddlm")),
                      chain_id = chain_id, iter = iter)
}
