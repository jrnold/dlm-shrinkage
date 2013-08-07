expand_dim <- function(x, n) {
  xdim <- length(dim(x))
  if (xdim < n) {
    if (xdim == 0) {
      array(x, c(length(x), rep(1, n - 1)))
    } else {
      array(x, c(dim(x), rep(1, n - length(dim(x)))))
    }
  } else {
    x
  }
}


is_constant <- function(x) sum(duplicated(x)) == (length(x) - 1)
