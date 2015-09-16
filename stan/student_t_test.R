library("rstan")
library("dplyr")
library("ggplot2")

tau <- 1
model <- stan_model("student_t_test.stan")
ret <- sampling(model, chains = 1, iter = 64000,
                data = list(tau = tau, nu = 1))


samples <-
  bind_rows(data_frame(y = as.numeric(rstan::extract(ret, "y1")[[1]]),
                       from = "exact"),
            data_frame(y = as.numeric(rstan::extract(ret, "y2")[[1]]),
                       from = "mix"),
            data_frame(y = as.numeric(rstan::extract(ret, "y3")[[1]]),
                       from = "normal")
            )

ggplot(samples, aes(x = y, colour = from)) + geom_density() +
  scale_x_continuous(limits = c(-5 * tau, 5 * tau))
