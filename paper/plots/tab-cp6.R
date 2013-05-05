source("conf.R")
OUTFILE <- commandArgs(TRUE)[1]

summary_cp6 <- RDATA[["summary_cp6"]]
print(xtable(data.frame(WAIC = round(sapply(summary_cp6, `[[`, i = "waic")),
                        `$p$` = round(sapply(summary_cp6, function(x) x[["waic"]]@b)),
                        `$L$` = round(sapply(summary_cp6, function(x) x[["waic"]]@loglik)),
                        MSE = round(sapply(summary_cp6, `[[`, i = "mse")),
                        `$\\chi^2$` = round(sapply(summary_cp6, `[[`, i = "chisq")),
                        check.names = FALSE,
                        row.names = names(summary_cp6)),
             digits = 0),
      sanitize.colnames.function = identity,
      sanitize.rownames.function = identity,
      floating = FALSE,
      file = OUTFILE)

