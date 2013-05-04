#' @export discrepancy
#' @export prgt0
#' @export prgte0
#' @export prlt0
#' @export prlte0
NULL

discrepancy_mse <- function(y, yrep) {
  ey <- apply(yrep, 1, mean)
  mean((y - ey)^2)
}

discrepancy_chisq <- function(y, yrep) {
  ey <- apply(yrep, 1, mean)
  vy <- apply(yrep, 1, var)
  sum((y - ey)^2 / vy)
}

discrepancy <- function(y, yrep, dist = "chisq") {
  f <- get(sprintf("discrepancy_%s", dist))
  f(y, yrep)
}

prgt0 <- function(x) sum(x > 0) / length(x)

prgte0 <- function(x) sum(x >= 0) / length(x)

prlt0 <- function(x) sum(x < 0) / length(x)

prlte0 <- function(x) sum(x <= 0) / length(x)

