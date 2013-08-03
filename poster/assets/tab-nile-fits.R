cmdargs <- commandArgs(TRUE)
FILE <- cmdargs[1]
source("conf.R")

fit_summary <- function(k) {
  x <- RDATA[[k]]
  data.frame(waic = as.integer(round(as.numeric(x[["waic"]]))),
             loglik = as.integer(round(x[["waic"]]@loglik)),
             bias = round(x[["waic"]]@b, 1),
             rmse = as.integer(round(sqrt(x[["mse"]]))))
}

modelnames <- c("normal_1", "normal_2", "hs")
keys <- sprintf("mcmcsummary_nile_%s", modelnames)
modelfits <- ldply(keys, fit_summary)
rownames(modelfits) <- sprintf("\\texttt{%s}", gsub("_", "\\\\_", modelnames))
colnames(modelfits) <- c("WAIC", "$L$", "$p$", "RMSE")
print(xtable(modelfits,  digits = 1), file = FILE,
      sanitize.text.function = identity,
      floating = FALSE)


