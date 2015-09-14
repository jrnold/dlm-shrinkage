#' Blocks function
#'
#' The blocks function from Donoho and Johnstone (1994),
#'
#' \deqn{
#' f(x) = \sum h_j K(x - t_j); K(t) = \frac{1 + sgn(x)}{2}
#' }{
#'  f(x) = sum( h_j K(x - t_j); K(t) = (1 + sgn(x)) / 2 )
#' }
#' The \code{blocks} function is this general case.
#' The \code{blocks_dj94} function uses the values of \code{t_j} and \code{h_j}
#' in the original paper
#' \deqn{
#' (t_j) = (0.1, 0.13, 0.15, 0.23, 0.25, 0.40, 0.44, 0.65, 0.76, 0.78, 0.81)
#' }
#' and
#' \deqn{
#' (h_j) = (4, -5, 3, -4, 5, -4.2, 2.1, 4.3, -3.1, 2.1, -4.2)
#' }
#' The original paper used the range (0, 1).
#'
#' @param x numeric. See description.
#' @param t numeric. See description.
#' @param h numeric. See description.
#' @references
#' Donoho, David L, and Johnstone, Iain M. (1994) "Ideal spatial adaptation by wavelet shrinkage."
#' \emph{Biometrika} \strong{81.3}, 425-55.
#' @examples
#' x <- seq(0, 1, length = 2048)
#' plot(x, blocks_dj94(x), type = "l")
#' @rdname blocks
#' @export
blocks <- function(x, t, h) {
  K <- function(x) (1 + sign(x)) / 2
  f <- function(x) sum(h * K(x - t))
  sapply(x, f)
}

#' @export
#' @rdname blocks
blocks_dj94 <- function(x) {
  t <- c(0.1, 0.13, 0.15, 0.23, 0.25, 0.40, 0.44, 0.65, 0.76, 0.78, 0.81)
  h <- c(4, -5, 3, -4, 5, -4.2, 2.1, 4.3, -3.1, 2.1, -4.2)
  blocks(x, t, h)
}

#' Bumps function
#'
#' The Bumps function from Donoho and Johnstone (1994) defined as,
#' \deqn{
#' f(x) = \sum h_j K((x - t_j) / w_j), K(x) = (1 + |x|)^{-4}
#' }{
#' f(x) = sum( h_j K((x - t_j) / w_j), K(x) = (1 + |x|)^{-4})
#' }
#' The function \code{bumps} is the general function.
#' The function \code{bumps_dj94} uses the specific parameters in the paper,
#' \deqn{
#' (t_j) = (0.1, 0.13, 0.15, 0.23, 0.25, 0.40, 0.44, 0.65, 0.76, 0.78, 0.81)
#' }
#' and
#' \deqn{
#' (h_j) = (4, 5, 3, 4, 5, 4.2, 2.1, 4.3, 3.1, 5.1, 4.2)
#' }
#' and
#' \deqn{
#' (w_j) = (0.005, 0.005, 0.006, 0.01, 0.01, 0.03, 0.01, 0.01, 0.005, 0.008, 0.005)
#' }
#' for the range (0, 1).
#'
#' @param x numeric. See description.
#' @param t numeric. See description.
#' @param h numeric. See description.
#' @param w numeric. See description.
#' @examples
#' x <- seq(0, 1, length.out = 2048)
#' plot(x, bumps_dj94(x), type = "l")
#' @references
#' Donoho, David L, and Johnstone, Iain M. (1994) "Ideal spatial adaptation by wavelet shrinkage."
#' \emph{Biometrika} \strong{81.3}, 425-55.
#' @family DonohoJohnstone1994
#' @rdname bumps
#' @export
bumps <- function(x, t, h, w) {
  K <- function(x) (1 + abs(x)) ^ -4
  f <- function(x) sum(h * K((x - t) / w))
  sapply(x, f)
}

#' @rdname bumps
#' @export
bumps_dj94 <- function(x) {
  t <- c(0.1, 0.13, 0.15, 0.23, 0.25, 0.40, 0.44, 0.65, 0.76, 0.78, 0.81)
  h <- c(4, 5, 3, 4, 5, 4.2, 2.1, 4.3, 3.1, 5.1, 4.2)
  w <- c(0.005, 0.005, 0.006, 0.01, 0.01, 0.03, 0.01, 0.01, 0.005, 0.008, 0.005)
  bumps(x, t, h, w)
}


#' HeaviSine Function
#'
#' The HeaviSine function fom Donoho and Johnstone (1994),
#' \deqn{
#' f(x) = a \sin a \pi x - sgn (x - b) - sgn(c - x)
#' } {
#' f(x) = a * sin(a * pi * x) - sgn(x - b) - sgn(c - x)
#' }
#' The function \code{heavisine} is the general case.
#' The function \code{heavisine_dj94} is the case used in the paper: \eqn{a = 4}, \eqn{b = 0.3}, and \eqn{c = 0.72}
#'
#' @param x numeric. See description.
#' @param a numeric. See description.
#' @param b numeric. See description.
#' @param c numeric. See description.
#' @references
#' Donoho, David L, and Johnstone, Iain M. (1994) "Ideal spatial adaptation by wavelet shrinkage."
#' \emph{Biometrika} \strong{81.3}, 425-55.
#' @family DonohoJohnstone1994
#' @examples
#' x <- seq(0, 1, length.out = 2048)
#' plot(x, heavisine_dj94(x), type = "l")
#' @rdname heavisine
#' @export
heavisine <- function(x, a, b, c) {
  a * sin(a * base::pi * x) - sign(x - b) - sign(c - x)
}

#' @rdname heavisine
#' @export
heavisine_dj94 <- function(x) {
  heavisine(x, 4, 0.3, 0.72)
}


#' Doppler function
#'
#' The Doppler function from Donoho and Johnstone (1994),
#' \deqn{
#' f(x) = (x (1 - x)^{\frac{1}{2}} \sin (2 \pi (1 + \epsilon) / (x + \epsilon))
#' }{
#' f(x) = (x (1 - x))^(1 / 2) * sin (2 * pi * (1 + e) / (x + e))
#' }
#' The function \code{doppler} is the general case.
#' The function \code{dollper_dj94} is the special case considered in the paper, \eqn{epsilon = 0.05}.
#'
#' @param x numeric. See description.
#' @param eps numeric. See description.
#' @references
#' Donoho, David L, and Johnstone, Iain M. (1994) "Ideal spatial adaptation by wavelet shrinkage."
#' \emph{Biometrika} \strong{81.3}, 425-55.
#' @family DonohoJohnstone1994
#' @examples
#' x <- seq(0, 1, length.out = 2048)
#' plot(x, doppler_dj94(x), type = "l")
#' @export
#' @rdname doppler
doppler <- function(x, eps) {
  sqrt(x * (1 - x)) * sin( 2 * base::pi * (1 + eps) / (x + eps))
}

#' @rdname doppler
#' @export
doppler_dj94 <- function(x) {
  doppler(x, eps = 0.05)
}




