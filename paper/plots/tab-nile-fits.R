fit_summary <- function(k) {
  x <- RDATA[[k]]
  data.frame(waic = as.integer(round(as.numeric(x[["waic"]]))),
             loglik = as.integer(round(x[["waic"]]@loglik)),
             bias = round(x[["waic"]]@b, 1),
             rmse = as.integer(round(sqrt(x[["mse"]]))),
             chisq = as.integer(round(x[["chisq"]])))
}

keys <- sprintf("mcmcsummary_nile_%s", c("hs", "normal_1", "normal_2"))
modelfits <- ldply(keys, fit_summary)
rownames(modelfits) <- c("$M_{hs}$", "$M_{normal,1}$", "$M_{normal,2}$")
colnames(modelfits) <- c("WAIC", "$L$", "$p$", "RMSE", "$\\Chi^2$")
print(xtable(modelfits,  digits = 1),
      sanitize.text.function = identity,
      floating = FALSE)

