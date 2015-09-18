#' Interval includes zero
#'
#' Check whether an interval includes zero.
#'
#' @param x interval endpoints
#' @param y interval endpoints
#' @param include \code{logical}. If \code{TRUE} then
#' returns \code{TRUE} if 0 is one of the endpoints.
#' @return \code{logical} vector indicating whether
#' the intervals [\code{x}, code{y}], include or cross zero.
#' @export
crosszero <- function(x, y, include=TRUE) {
  
  if (include) {
    f <- `<=`
  } else {
    f <- `<`
  }
  f((sign(x) * sign(y)), 0)
}
