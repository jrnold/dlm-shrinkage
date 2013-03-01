library(rstan)
library(plyr)

model <- stan_model("../stan/models/llhorseshoe.stan")

MAX_DATE <- as.Date("1866-12-31")
MIN_DATE <- as.Date("1862-1-1")

greenbacks <-
  subset(mutate(read.delim("../data/greenbacks.csv"),
                date = as.Date(dt),
                dt = NULL,
                y = (log(high) + log(low)) * 0.5,
                y_time = as.integer(date - MIN_DATE + 1)),
         date >= MIN_DATE & date <= MAX_DATE)

data <- list(n_obs = sum(!is.na(greenbacks$y)),
             n_time = as.integer(MAX_DATE - MIN_DATE + 1),
             y = na.omit(greenbacks$y),
             y_time = na.omit(greenbacks2$y_time),
             theta1_mean = log(100),
             theta1_sd = 0.01)

tsmodel <- StructTS(greenbacks$y, "level")
theta <- tsSmooth(tsmodel)[ , 1]

init <- list(within(list(), {
  logsigma = log(mean(diff(greenbacks$y)^2, na.rm=TRUE) / 2)
  theta_innov = c(0, diff(theta))
  lambda = rep(0.05, data$n_time - 1)
  tau = exp(logsigma)
}))
             
ret <- sampling(model, data=data, iter=2000, chains=1, init=init)

