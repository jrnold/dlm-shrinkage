#' @include utilities.R
#' @export array_to_tvmat
#' @export tvmat_to_array
NULL

array_to_tvmat <- function(x) {
  X_const <- x[, , 1]
  n <- dim(x)[3]
  if (n > 1) {
    is_tv <- apply(x, 1:2, Negate(is_constant))
    n_tv_ind <- sum(is_tv)
    if (n_tv_ind > 0) {
      tv_data <- matrix(0, n, n_tv_ind)
      tv_data <- x[is_tv, drop=FALSE]
      dim(tv_data) <- c(n_tv_ind, n)
      Jx <- matrix(0, dim(x)[1], dim(x)[2])
      Jx[is_tv] <- 1:n_tv_ind
      list(constant = X_const, indices = Jx, tv_data = t(tv_data))
    } else {
      list(constant = x[ , , 1], indices = NULL, tv_data = NULL)
    }
  } else {
    list(constant = x, indices = NULL, tv_data = NULL)
  }
}

tvmat_to_array <- function(x, indices = NULL, tv_data = NULL) {
  if (is.null(indices)) {
    array(x, c(dim(x), 1L))
  } else {
    n <- nrow(tv_data)
    xarr <- replicate(n, x)
    for (i in seq_len(nrow(x))) {
      for (j in seq_len(ncol(x))) {
        if (indices[i, j] > 0) {
          xarr[i, j, ] <- tv_data[indices[i, j]]
        }
      }
    }
    xarr
  }
}
