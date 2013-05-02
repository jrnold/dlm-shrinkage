model_hs <- "../stan/models/horseshoe.stanx"
model_hs2 <- "../stan/models/horseshoe2.stanx"
model_hs3 <- "../stan/models/horseshoe3.stanx"
model_hs4 <- "../stan/models/horseshoe4.stanx"
model_normal <- "../stan/models/normal.stanx"

SEED <- c(64425843)
ITER <- 2^15
WARMUP <- 2^14
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

cp6 <- read.csv("../data/CP6.csv")
cp6[["date"]] <- as.Date(sprintf("%d-%d-1", cp6[["year"]], cp6[["month"]]))

cp6_data <- list(n_obs = nrow(cp6),
                 n_time = nrow(cp6),
                 y = cp6[["sales"]],
                 y_time = seq_len(nrow(cp6)),
                 theta1_mean = 610,
                 theta1_sd = 50,
                 nu = 4)

cp6_smpl1 <- run_stan_model(model_normal,
                            data = cp6_data, seed=SEED,
                            iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_cp6_normal"]] <- mcmcdb_wide_from_stan(cp6_smpl1, model_name = "normal")

cp6_smpl2 <- run_stan_model(model_hs,
                            data = cp6_data, seed=SEED,
                            iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_cp6_hs"]] <- mcmcdb_wide_from_stan(cp6_smpl2, model_name = "horseshoe")

cp6_smpl3 <- run_stan_model(model_hs2,
                            data = cp6_data, seed=SEED,
                            iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_cp6_hs2"]] <- mcmcdb_wide_from_stan(cp6_smpl3, model_name = "horseshoe2")

cp6_data_2 <- list(n_obs = nrow(cp6),
                 n_time = nrow(cp6),
                 y = cp6[["sales"]],
                 y_time = seq_len(nrow(cp6)),
                 theta_mean = c(610, 0),
                 theta_sd = c(50, 50),
                 nu = 4)

cp6_smpl4 <- run_stan_model(model_hs4,
                            data = cp6_data_2,
                            seed=SEED, iter = ITER, warmup = WARMUP, thin = THIN)
RDATA[["mcmcdb_cp6_hs4"]] <- mcmcdb_wide_from_stan(cp6_smpl4, model_name = "horseshoe4")
