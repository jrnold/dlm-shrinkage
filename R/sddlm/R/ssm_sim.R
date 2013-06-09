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

yhat_from_ssm <- function(object, alpha) {
  FUN <- function(alpha, Z) {
    as.numeric(Z[[1]] %*% alpha[[1]])
  }
  res <- mlply(data.frame(alpha = I(alply(alpha, 2, identity)),
                           Z = I(ssmodel_array2list(object$Z, object$n))),
                .fun = FUN)
  simplify2array(res)
}

dist_obs_from_ssm <- function(object, alpha) {
  FUN <- function(y, alpha, Z) {
    as.numeric(y[[1]] - Z[[1]] %*% alpha[[1]])
  }
  y <- alply(as.matrix(object[["y"]]), 1, identity)
  res <- mlply(data.frame(y = I(y),
                          alpha = I(alply(alpha, 2, identity)),
                          Z = I(ssmodel_array2list(object$Z, object$n))),
                .fun = FUN)
  simplify2array(res)
}

dist_state_from_ssm <- function(object, alpha) {
  FUN <- function(alpha, T, lalpha) {
    as.numeric(alpha[[1]] - T[[1]] %*% lalpha[[1]])
  }
  lalpha <- c(list(object$a1), alpha[1:(length(alpha) - 1)])
  res <- mlply(data.frame(alpha = I(alply(alpha, 2, identity)),
                          lalpha = I(lalpha),
                          T = I(ssmodel_array2list(object$T, object$n))),
                .fun = FUN)
  simplify2array(res)
}


# alpha: m x 1 x n
# Z: p x m x n
# H: p x p x n
yrep_from_ssm <- function(n, object, alpha) {
  FUN <- function(alpha, Z, H) {
    mu <- Z[[1]] %*% alpha[[1]]
    H <- H[[1]]
    if (length(mu) > 1) { 
      drop(rmvnorm(n, mu, H))
    } else {
      rnorm(n, mu, sqrt(H))
    }
  }
  res <- mlply(data.frame(alpha = I(alply(alpha, 2, identity)),
                          Z = I(ssmodel_array2list(object$Z, object$n)),
                          H = I(ssmodel_array2list(object$H, object$n))),
               .fun = FUN)
  simplify2array(res)
}

ssm_sim <- function(object, data = mcmcdb_data(object), .parallel=FALSE) {
  FUN <- function(iter, data, to_ssm) {
    ssmodel <- to_ssm(iter)
    alpha <- simulateSSM(ssmodel, "states")[["states"]]
    dim(alpha) <- dim(alpha)[1:2]
    yrep <- yrep_from_ssm(1, ssmodel, alpha)
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
                      .parallel = .parallel,
                      .paropts = list(.packages = c("sddlm")))
                      
}
