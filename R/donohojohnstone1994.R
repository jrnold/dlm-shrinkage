#' Functions to generate simulation data from Donoho and Johnstone
#'
#' 
#' Blocks
#'
#' $$
#' \begin{align}
#' f(t) &= \sum h_j K(t - t_j)
#' K(t) &= \frac{1 + \sign(t)}{2}
#' \end{align}
#' $$
blocks <- function(t, tj, hj) {
    K <- function(x) (1 + sign(x)) / 2
    f <- function(x) sum(hj * K(x - tj))
    sapply(x, f)
}
tj <- c(0.1, 0.13, 0.15, 0.23, 0.25, 0.40, 0.44, 0.65, 0.76, 0.78, 0.81)
hj <- c(4, -5, 3, -4, 5, -4.2, 2.1, 4.3, -3.1, 2.1, -4.2)
t <- seq(0, 1, length = 1000)
plot(t, blocks(t, tj, hj), type = "l")

bumps <- function(x, tj, hj, wj) {
    K <- function(x) (1 + abs(x)) ^ -4
    f <- function(x) sum(hj * K((x - tj) / wj))
    sapply(x, f)
}
tj <- c(0.1, 0.13, 0.15, 0.23, 0.25, 0.40, 0.44, 0.65, 0.76, 0.78, 0.81)
hj <- c(4, 5, 3, 4, 5, 4.2, 2.1, 4.3, 3.1, 5.1, 4.2)
wj <- c(0.005, 0.005, 0.006, 0.01, 0.01, 0.03, 0.01, 0.01, 0.005, 0.008, 0.005)
t <- seq(0, 1, length = 1000)
plot(t, bumps(t, tj, hj, wj), type = "l")

heavisine <- function(t) {
    4 * sin(4 * base::pi * x) - sign(x - 0.3) - sign(0.72 - x)
}
plot(t, heavisine(t), type = "l")

doppler <- function(x, eps = 0.05) {
    sqrt(t * (1 - t)) * sin( 2 * base::pi * (1 + eps) / (x + eps))
}
plot(t, doppler(t), type = "l")
