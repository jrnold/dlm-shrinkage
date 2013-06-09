#' @export prgt0
#' @export prgte0
#' @export prlt0
#' @export prlte0
NULL

#' Miscellanoues functions
#'
#' @param x Numeric vector
#'
#' @section Details:
#'
#' \describe{
#' \item{\code{prgt0}}{Probability \code{x} greater than 0}
#' \item{\code{prle0}}{Probability \code{x} greater than or equal to 0}
#' \item{\code{prlt0}}{Probability \code{x} less than 0}
#' \item{\code{prlte0}}{Probability \code{x} less than or equal to 0}
#' }
prgt0 <- function(x) sum(x > 0) / length(x)

#' @rdname prgt0
prgte0 <- function(x) sum(x >= 0) / length(x)

#' @rdname prgt0
prlt0 <- function(x) sum(x < 0) / length(x)

#' @rdname prgt0
prlte0 <- function(x) sum(x <= 0) / length(x)
