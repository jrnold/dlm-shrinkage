library("rstan")
library("dplyr")
library("ggplot2")

model <- stan_model("double_exponential_test.stan")
ret <- sampling(model, chains = 1, iter = 32000, data = list(tau = 0.1))


samples <-
  bind_rows(data_frame(y = as.numeric(rstan::extract(ret, "y1")[[1]]),
                       from = "de"),
            data_frame(y = as.numeric(rstan::extract(ret, "y2")[[1]]),
                       from = "mix"))

ggplot(samples, aes(x = y, colour = from)) + geom_density()
