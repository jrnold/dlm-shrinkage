source('conf.R')
nile <- RDATA[["nile"]]
summary_nile <- RDATA[["summary_nile"]]

hs_innov <- summary_nile[["hs"]][["innovations"]]
hs_innov_t <- apply(hs_innov, 1, function(x) mean(x) / sd(x))

pr_positive <- function(x) {
  sum(x >= 0) / length(x)
}

pr_negative <- function(x) {
  sum(x <= 0) / length(x)
}

pr_outlier <- function(x) {
  2 * (max(pr_positive(x), pr_negative(x)) - 0.5)
}

foo <- apply(hs_innov, 1, pr_outlier)
foo <- apply(summary_nile[["normal"]][["innovations"]], 1, pr_outlier)
foo <- apply(summary_nile[["normal2"]][["innovations"]], 1, pr_outlier)


