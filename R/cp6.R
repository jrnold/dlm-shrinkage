library(rstan)
library(plyr)
library(reshape2)
library(ggplot2)

data(Nile)

model_hs <- stan_model("../stan/models/llhorseshoe.stan")
model_norm <- stan_model("../stan/models/llnormal.stan")

cp6 <- mutate(read.csv("../data/CP6.csv"),
              ym = year + (month - 1) / 12)

data <- list(n_obs = nrow(cp6),
             n_time = nrow(cp6),
             y = cp6$sales,
             y_time = seq_len(nrow(cp6)),
             theta1_mean = 620,
             theta1_sd = 50)

ret_hs <- sampling(model, data=data, iter=2000, chains=1)
theta_hs <- apply(extract(ret_hs, "theta")[[1]], 2, mean)

ret_norm <- sampling(model_norm, data=data, iter=2000, chains=1)
theta_norm <- apply(extract(ret_norm, "theta")[[1]], 2, mean)

(ggplot(mutate(cp6, horseshoe = theta_hs, normal=theta_norm), aes(x=ym)) + geom_point(aes(y=sales))
 + geom_line(aes(y=horseshoe), colour="blue")
 + geom_line(aes(y=normal), colour="red"))


nile <- as.numeric(Nile)

data <- list(n_obs = length(nile),
             n_time = length(nile),
             y = nile,
             y_time = seq_len(length(nile)),
             theta1_mean = 919,
             theta1_sd = 169 * 2)

ret_hs <- sampling(model, data=data, iter=4000, chains=1)
theta_hs <- apply(extract(ret_hs, "theta")[[1]], 2, mean)

ret_norm <- sampling(model_norm, data=data, iter=2000, chains=1)
theta_norm <- apply(extract(ret_norm, "theta")[[1]], 2, mean)

lambda <- melt(extract(ret_hs, "lambda")[[1]])
ggplot(lambda, aes(x=Var2, y=value)) + geom_point()
ggplot(lambda, aes(x=Var2, y=1 - 1 / (1 + value^2))) + geom_point()

tau <- extract(ret_hs, "tau")


(ggplot(data.frame(year = seq(1871, 1970, 1), y = nile,
                   horseshoe = theta_hs, normal=theta_norm), aes(x=year))
 + geom_point(aes(y=y))
 + geom_line(aes(y=horseshoe), colour="blue")
 + geom_line(aes(y=normal), colour="red"))


