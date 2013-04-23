library(stanmisc)
library(mcmcdb)

model_hs <- "../stan/models/horseshoe"
model_hs2 <- "../stan/models/horseshoe2"
model_hs3 <- "../stan/models/horseshoe3"
model_normal <- "../stan/models/normal"

SEED <- c(64425843)
ITER <- 2^14
WARMUP <- 2^13
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

cp6 <- read.csv("../data/CP6.csv")
cp6[["date"]] <- as.Date(sprintf("%d-%d-1", cp6[["year"]], cp6[["month"]]))

cp6_data <- list(n_obs = nrow(cp6),
                 n_time = nrow(cp6),
                 y = cp6[["sales"]],
                 y_time = seq_len(nrow(cp6)),
                 theta1_mean = 610,
                 theta1_sd = 50)

cp6_data2 <- list(n_obs = nrow(cp6),
                  n_time = nrow(cp6),
                  y = cp6[["sales"]],
                  y_time = seq_len(nrow(cp6)),
                  theta1_mean = c(610, 0),
                  theta1_sd = c(50, 100))

cp6_samples2 <- run_stan_model(model_normal,
                              data = cp6_data, seed=SEED,
                              iter = ITER, warmup = WARMUP, thin = THIN)
mcmcdb_cp6_normal <- mcmcdb_wide_from_stan(cp6_samples2)

cp6_samples1 <- run_stan_model(model_hs,
                              data = cp6_data, seed=SEED,
                              iter = ITER, warmup = WARMUP, thin = THIN)
mcmcdb_cp6_hs <- mcmcdb_wide_from_stan(cp6_samples1)

cp6_samples3 <- run_stan_model(model_hs2,
                              data = cp6_data2, seed=SEED,
                              iter = ITER, warmup = WARMUP, thin = THIN)
mcmcdb_cp6_hs2 <- mcmcdb_wide_from_stan(cp6_samples3)

cp6_samples4 <- run_stan_model(model_hs3,
                              data = cp6_data2, seed=SEED,
                              iter = ITER, warmup = WARMUP, thin = THIN)
mcmcdb_cp6_hs3 <- mcmcdb_wide_from_stan(cp6_samples4)


hs <- summary(mcmcdb_cp6_hs, pararrays = "yhat")[[1]]
hs2 <- summary(mcmcdb_cp6_hs3, pararrays = "yhat")[[1]]
normal <- summary(mcmcdb_cp6_normal, pararrays = "yhat")[[1]]
foo <- data.frame(date = cp6[["date"]], y = cp6[["sales"]], normal = normal, hs = hs, hs2 = hs2)
(ggplot(foo, aes(x = date))
 + geom_line(aes(y = normal), colour = "red")
 + geom_line(aes(y = hs), colour = "blue")
 + geom_line(aes(y = hs2), colour = "green")
 + geom_point(aes(y = y)))

ggplot(ests, aes(x=n)) + geom_line(aes(y=value, colour=variable)) + geom_point(aes(y=y))
plot(as.numeric(mcmcdb_nile_normal[["tau"]]))
plot(as.numeric(mcmcdb_nile_normal[["sigma"]]))
plot(as.numeric(mcmcdb_nile_normal[["deviance"]]))
