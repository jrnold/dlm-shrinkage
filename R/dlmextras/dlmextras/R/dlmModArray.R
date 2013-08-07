#' @include utilities.R
NULL

#' @export
dlmModArray <- function(FF, GG, V, W, m0, C0) {
  i <- 0
  X <- NULL

  # FF
  FF <- expand_dim(FF, 3)
  GG <- expand_dim(GG, 3)
  V <- expand_dim(V, 3)
  W <- expand_dim(W, 3)
  if (dim(FF)[3] > 1) {
    FFmat <- tvmat_to_array(FF)
    FF <- FFmat[["constant"]]
    JFF <- FFmat[["indices"]] + i
    X <- cbind(X, FFmat[["tv_data"]])
    i <- i + sum(JFF)
  } else {
    dim(FF) <- dim(FF)[1:2]
    JFF <- NULL
  }
  if (dim(GG)[3] > 1) {
    GGmat <- tvmat_to_array(GG)
    GG <- GGmat[["constant"]]
    JGG <- GGmat[["indices"]] + i
    X <- cbind(X, GGmat[["tv_data"]])
    i <- i + sum(JGG)
  } else {
    dim(GG) <- dim(GG)[1:2]
    JGG <- NULL
  }
  if (dim(V)[3] > 1) {
    Vmat <- tvmat_to_array(V)
    V <- Vmat[["constant"]]
    JV <- Vmat[["indices"]] + i
    X <- cbind(X, Vmat[["tv_data"]])
    i <- i + sum(JV)
  } else {
    dim(V) <- dim(V)[1:2]
    JV <- NULL
  }
  if (dim(W)[3] > 1) {
    Wmat <- tvmat_to_array(W)
    W <- Wmat[["constant"]]
    JW <- Wmat[["indices"]] + i
    X <- cbind(X, Wmat[["tv_data"]])
    i <- i + sum(JW)
  } else {
    dim(W) <- dim(W)[1:2]
    JW <- NULL
  }
  dlm(FF = FF, GG = GG, V = V, W = W,
      JFF = JFF, JGG = JGG, JV = JV, JW = JW,
      X = X, m0 = m0, C0 = C0)
}
