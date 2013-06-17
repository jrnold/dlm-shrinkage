library(dlm)
library(mvtnorm)
library(stanmisc)

##' @export
dlmGet <- function(mod, i, t) {
    .dlmTv <- function(mod, x, jx, t) {
        y <- mod[[x]]
        if (!is.null(mod[[jx]])) {
            T <- nrow(mod$X)
            if (t <= T) {
                for (i in seq_len(nrow(mod[[jx]]))) {
                    for (j in seq_len(ncol(mod[[jx]]))) {
                        k <- mod[[jx]][i, j]
                        if (k > 0) {
                            y[i, j] <- mod$X[t, k]
                        }
                    }
                }
            }
            ## If t > nrow of X, then use defaults
        }
        y
    }
    switch(i,
           G = .dlmTv(mod, "GG", "JGG", t),
           F = .dlmTv(mod, "FF", "JFF", t),
           V = .dlmTv(mod, "V", "JV", t),
           W = .dlmTv(mod, "W", "JW", t),
           NULL)
}

##' @export
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

print_eigen <- function(mod) {
  for (i in c("FF", "GG", "V", "W")) {
    cat(sprintf("%s << %s;\n", i,
                paste(as.character(t(mod[[i]])), collapse=",")))
  }
}

dump_model <- function(mod, y, file) {
  data <- list(FF = mod$FF, GG = mod$GG, V = mod$V, W = mod$W, y = y)
  env <- as.environment(data)
  write_rdump(ls(env), envir = env, file = eval(file))
}

set.seed(12345)
UU <- dlmRandom(1, 1)
C0(UU) <- 1e7
print_eigen(UU)
y <- dlmSim(UU, n= 10)$y
cat(sprintf("%s << %s;\n", "y", paste(y, collapse=", ")))
as.character(dlmLL(y, UU))
dump_model(UU, y, file="UU-data.R")


set.seed(12345)
MU <- dlmRandom(2, 1)
C0(MU) <- matrix(1e7)
y <- dlmSim(MU, n= 10)$y

set.seed(12345)
UM <- dlmRandom(1, 3)
C0(UM) <- diag(3) * 1e7
y <- dlmSim(UM, n= 10)$y

set.seed(12345)
MM <- dlmRandom(2, 3)
C0(MM) <- diag(3) * 1e7
y <- dlmSim(MM, n= 10)$y
dlmLL(y, MM)
