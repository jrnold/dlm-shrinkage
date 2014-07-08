library("plyr")

bhscene <- function(n, mu, sigma) {
    mutate(plyr::mdply(data.frame(n = n, mean = mu, sd = sigma),
                       function(n, mean, sd) {
                           data.frame(x = rnorm(n, mean, sd))
                       }),
           i = seq_along(n))
}
params <-
    list("01" = list(n = 60, mu = 0),
         "02" = list(n = c(40, 20), mu = c(0, 3)),
         "03" = list(n = c(40, 20), mu = c(0, 2)),
         "04" = list(n = c(30, 30), mu = c(0, 1)),
         "05" = list(n = c(30, 30), mu = c(0, 0.5)),
         "06" = list(n = c(58, 2), mu = c(0, 3)),
         "07" = list(n = c(15, 30, 15), mu = c(0, 2, 0)),
         "08" = list(n = c(10, 40, 10), mu = c(0, 1, 0)),
         "09" = list(n = c(30, 20, 10), mu = c(0, 2, 0)),
         "10" = list(n = c(4, 1, 55), mu = c(0, 5, 0)),
         "11" = list(n = c(10, 15, 20, 15), mu = c(1, 0, 2, 1)),
         "12" = list(n = c(10, 10, 10, 30), mu = c(1, 2, 1, 0)),
         "13" = list(n = c(25, 1, 14, 20), mu = c(2, 0, 5, 3)),
         "14" = list(n = c(15, 5, 5, 35), mu = c(3, 0, 5, 3)),
         "15" = list(n = c(5, 5, 40, 5, 5), mu = c(0, 2, 0, 2, 0)),
         "16" = list(n = rep(12, 5), mu = c(0, 1, 0, 1, 0)),
         "17" = list(n = rep(12, 5), mu = 0:4),
         "18" = list(n = c(14, 5, 1, 1, 4, 9, 15, 11), mu = c(3, 5, 0, 2, 5, 2, 3, 4)),
         "19" = list(n = c(2, 14, 15, 15, 5, 1, 5, 3), mu = c(1, 0, 1, 4, 1, 5, 0, 1)),
         "20" = list(n = rep(6, 10), mu = rep(c(0, 2), 5)))

foo <- plyr::ldply(params, function(x, sigma) bhscene(x$n, x$mu, sigma), sigma = 1)
