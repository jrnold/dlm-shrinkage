#' @include utilities.R
NULL

#' @export
dlmSim <- function(mod, n=NULL) {
  y <- matrix(0, ncol=ncol(mod$V), nrow=n)
  theta <- matrix(0, ncol=ncol(mod$W), nrow=n + 1)
  
  ## Initial value
  theta[1, ] <- rmvnorm(1, mod$m0, mod$C0)
  for (i in seq_len(n)) {
    F <- dlmGet(mod, "F", i)
    G <- dlmGet(mod, "G", i)
    V <- dlmGet(mod, "V", i)
    W <- dlmGet(mod, "W", i)
    ## draw from p(theta_t | theta_{t-1})
    theta[i + 1, ] <- rmvnorm(1, G %*% theta[i, ], W)
    ## draw from p(y_t | theta_{t})
    y[i, ] <- rmvnorm(1, F %*% theta[i + 1, ], V)
  }
  list(y=y, theta=theta)
}
