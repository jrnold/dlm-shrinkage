library(plyr)
library(boot)

model_hs <- "../stan/models/horseshoe_poisson"

SEED <- c(64425843)
ITER <- 2^16
WARMUP <- 2^14
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

coal2 <- ddply(mutate(coal, year = round(date)),
               "year", summarize, accidents = length(date))
missyr <- (1851:1962)[!1851:1962 %in% coal2[["year"]]]
coal2 <- rbind(coal2,
               data.frame(year = missyr,
                          accidents = 0))
coal2 <- arrange(coal2, year)

coal_data <- list(n_obs = nrow(coal2),
                  n_time = nrow(coal2),
                  y = coal2[["accidents"]],
                  y_time = seq_len(nrow(coal2)),
                  theta1_mean = log(coal2[["accidents"]][1]),
                  theta1_sd = sd(log(coal2[["accidents"]] + 0.5)),
                  sigma = sqrt(mean(coal2[["accidents"]] + 0.5)))

coal_smpl1 <- 
  run_stan_model(model_hs,
                 data = coal_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_coal"]] <- mcmcdb_wide_from_stan(coal_smpl1)

yhat <- apply(RDATA[["mcmcdb_coal"]][["yhat"]], 1, mean)
ggplot(mutate(coal2, yhat = yhat), aes(x=year)) + geom_point(aes(y = accidents)) + geom_line(aes(y  = yhat))

coal_smpl2 <- 
  run_stan_model("../stan/models/normal_poisson",
                 data = coal_data, seed=SEED,
                 iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_coal2"]] <- mcmcdb_wide_from_stan(coal_smpl2)

yhat2 <- apply(RDATA[["mcmcdb_coal2"]][["yhat"]], 1, mean)
ggplot(mutate(coal2, yhat = yhat, yhat2 = yhat2), aes(x=year)) + geom_point(aes(y = accidents)) + geom_line(aes(y  = yhat), colour="red") + geom_line(aes(y = yhat2), colour="blue")
