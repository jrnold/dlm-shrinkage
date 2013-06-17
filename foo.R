library(mvtnorm)
sample_dlm <- function(T, F=1, G=1, V=1, W=1, m0=1) {
  F <- as.matrix(F)
  G <- as.matrix(G)
  V <- as.matrix(V)
  W <- as.matrix(W)
  alpha <- m0
  y <- matrix(NA, ncol(F), n)
  for (i in 1:T) {
    alpha <- as.numeric(rmvnorm(1, G %*% alpha, W))
    y[ , i] <- as.numeric(rmvnorm(1, t(F) %*% alpha, V))
  }
  y
}

Vsd <- c(0.05, 1.5)
Vcorr <- 0.5
V <- Vsd %o% Vsd
V[1, 2] <- V[2, 1] <- V[1, 2] * Vcorr
F <- matrix(rep(1, 2), 1)
G <- 1
W <- 1
m0 <- 0

# Univariate / univariate

random_dlm <- function(n, 


y <- sample_dlm(5, F = F, G = G, V = V, W = 1, m0 = 0)
dlmLL(y, dlm(FF = t(F), GG = G, V = V, W = W, m0 = 0, C0 = 1))

