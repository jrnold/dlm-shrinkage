source("conf.R")
OUTFILE <- commandArgs(TRUE)[1]

summary_nile <- RDATA[["summary_nile"]]
print(xtable(data.frame(WAIC = round(sapply(summary_nile, `[[`, i = "waic")),
                        `$p$` = round(sapply(summary_nile, function(x) x[["waic"]]@b)),
                        `$L$` = round(sapply(summary_nile, function(x) x[["waic"]]@loglik)),
                        MSE = round(sapply(summary_nile, `[[`, i = "mse")),
                        `$\\chi^2$` = round(sapply(summary_nile, `[[`, i = "chisq")),
                        check.names = FALSE,
                        row.names = names(summary_nile)),
             digits = 0),
      sanitize.colnames.function = identity,
      sanitize.rownames.function = identity,
      floating = FALSE,
      file = OUTFILE)

