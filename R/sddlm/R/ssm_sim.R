#' @include dlm_to_ssmodel-method.R
#' @export ssm_sim
NULL

ssm_array2list <- function(x, n) {
  if (dim(x)[3] > 1) {
    llply(seq_len(n),
          function(i) {
            x[ , , i]
            dim(x) <- dim(x)[1:2]
            x
          })
  } else {
    replicate(n, {dim(x) <- dim(x)[1:2]; x}, simplify=FALSE)
  }
}

yhat_from_ssm <- function(object, alpha) {
  FUN <- function(alpha, Z) {
    Z[[1]] %*% alpha[[1]]
  }
  mlply(data.frame(alpha = I(alply(alpha, 2, identity)),
                   Z = I(ssm_array2list(object$Z, object$n))),
        .fun = FUN)
}

# alpha: m x 1 x n
# Z: p x m x n
# H: p x p x n
yrep_from_ssm <- function(n, object, alpha) {
  FUN <- function(alpha, Z, H) {
    mu <- Z[[1]] %*% alpha[[1]]
    H <- H[[1]]
    if (length(mu) > 1) { 
      rmvnorm(n, mu, H)
    } else {
      rnorm(n, mu, H)
    }
  }
  mlply(data.frame(alpha = I(alply(alpha, 2, identity)),
                   Z = I(ssm_array2list(object$Z, object$n)),
                   H = I(ssm_array2list(object$H, object$n))),
        .fun = FUN)
}

ssm_sim <- function(object, data = mcmcdb_data(object)) {
  FUN <- function(iter, data, to_ssm) {
    ssmodel <- to_ssm(iter, data)
    alpha <- simulateSSM(ssmodel, "states")[["states"]]
    dim(alpha) <- dim(alpha)[1:2]
    yrep <- yrep_from_ssm(1, ssmodel, alpha)
    yhat <- yhat_from_ssm(ssmodel, alpha)
    loglik <- loglik_from_SSM(ssmodel)
    list(alpha = alpha, yhat = yhat, yrep = yrep, loglik = loglik)
  }
  mcmcdb_samples_iter(object, FUN,
                      data = mcmcdb_data(object),
                      to_ssm = dlm_to_ssmodel(object))
}
