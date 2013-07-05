FUN <- function(key) {
  data <- RDATA[[key]]
  data.frame(waic = as.numeric(data$waic),
             loglik = data$waic@loglik,
             waic_p = data$waic@b)
}

keys <- grep("mcmcsummary_afghan_", dbList(RDATA), value=TRUE)

afghan_models <- ldply(keys, FUN)
