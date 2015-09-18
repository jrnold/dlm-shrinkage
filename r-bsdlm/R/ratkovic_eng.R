#'  Functions from Ratkovic and Eng (2010)
#'
#' The functions used in the simulations in Ratkovic and Eng (2010).
#' This function is a Bessel function of the 2nd type with jumps,
#' \deqn{
#' g(x_i) = - 2 f (x_i / 100) + 8 I(x_i > 200) - 4 I(x_i > 500) + 2 I(x_i > 800)
#' }
#' The smooth function is a Bessel function of the 2nd type,
#' \deqn{
#' g(x_i) = - 2 f(x_i / 100)
#' }
#' In both functions, \eqn{f} is a Bessel function of the 2nd type.
#'
#' The simuations in the paper add random noise.
#'
#' @param x numeric. Input variable.
#' @references Ratkovic, Marc T. and Eng, Kevin H. "Finding Jumps in Otherwise Smooth Curves: Identifying Critical Events in Political Processes."
#' \emph{Political Analysis} \strong{18.1}, 57--77. \url{http://dx.doi.org/10.1093\%2Fpan\%2Fmpp032}
#' @rdname ratkovic_eng_jumps
#' @export
#' @examples
#' x <- 1:1000
#' plot(x, ratkovic_eng_jump(x), type = "l")
#' plot(x, ratkovic_eng_jump(x) + rnorm(length(x)), type = "p")
#' plot(x, ratkovic_eng_jump(x) + arima.sim(length(x), model = list(ar = 0.4), sd = 1),
#'      type = "p")
#' plot(x, ratkovic_eng_smooth(x), type = "l")
#' plot(x, ratkovic_eng_smooth(x) + + rnorm(length(x)), type = "l")
#' plot(x, ratkovic_eng_smooth(x) + arima.sim(length(x), model = list(ar = 0.4), sd = 1),
#'      type = "p")
ratkovic_eng_jump <- function(x) {
  -2 * besselJ(x / 100, 1) + 8 * (x > 200) - 4 * (x > 500) + 2 * (x > 800)
}

#' @rdname ratkovic_eng_jumps
#' @export
ratkovic_eng_smooth <- function(x) {
  -2 * besselJ(x / 100, 1)
}
