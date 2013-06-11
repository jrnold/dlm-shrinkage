cmdargs <- commandArgs(TRUE)
FILE <- cmdargs[1]

source("conf.R")

fit_summary <- function(k) {
  x <- RDATA[[k]]
  data.frame(waic = as.integer(round(as.numeric(x[["waic"]]))),
             loglik = as.integer(round(x[["waic"]]@loglik)),
             bias = round(x[["waic"]]@b, 1),
             rmse = as.integer(round(sqrt(x[["mse"]]), 2)),
             chisq = as.integer(round(x[["chisq"]])))
}

keys <- sprintf("mcmcsummary_bush_%s", c("hs", "normal"))
modelfits <- ldply(keys, fit_summary)
rownames(modelfits) <- c("\\Model{bush}{hs}", "\\Model{bush}{normal}")
colnames(modelfits) <- c("WAIC", "$L$", "$p$", "RMSE", "$\\chi^2$")
print(xtable(modelfits,  digits = 1),
      sanitize.text.function = identity,
      floating = FALSE,
      file = FILE)

