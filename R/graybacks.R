library(rstan)
library(plyr)

model <- stan_model("../stan/models/llhorseshoe2.stan")
graybacks <-
  mutate(read.delim("../data/grayback_weidenmier_2.tsv"),
         date = as.Date(date, "%Y %b %d"),
         y = log(price),
         y_time = seq_along(price))

MAX_DATE <- max(graybacks$date)
MIN_DATE <- min(graybacks$date)

data <- list(n_obs = nrow(graybacks),
             n_time = max(graybacks$y_time),
             y = graybacks$y,
             y_time = graybacks$y_time,
             theta1_mean1 = log(1),
             theta1_sd1 = 0.15,
             theta1_mean2 = 0,
             theta1_sd2 = 0.1)

tsmodel <- StructTS(graybacks$y, "trend")
theta <- tsSmooth(tsmodel)

init <- list(within(list(), {
  logsigma = log(tsmodel$coef["epsilon"])
  theta_innov1 = c(0, diff(theta[ , 1]))
  theta_innov2 = rnorm(length(theta_innov1), mean=0, sd=exp(logsigma))
  lambda1 = rep(0.05, data$n_time - 1)
  tau1 = exp(logsigma)
  lambda2 = rep(0.05, data$n_time - 1)
  tau2 = exp(logsigma)
}))
             
ret <- sampling(model, data=data, iter=2000, chains=1, init=init)

