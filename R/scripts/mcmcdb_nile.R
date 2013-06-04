nile <- RDATA[["nile"]]

SEED <- c(43542530304)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

nile_data <- list(n = nrow(nile),
                  y = nile$flow,
                  X = matrix(as.integer(nile$dam)),
                  k = 1L,
                  missing = rep(0L, length(nile$flow)),
                  a1 = nile$flow[1],
                  P1 = var(nile$flow))

RDATA[["mcmcdb_nile_hp"]] <-
  mcmcdb_wide_from_stan(run_stan_model(STAN_MODELS["local_level_hp"],
                                       data = nile_data, seed=SEED,
                                       init = init$nile_hp_v1,
                                       iter = ITER * 2,
                                       warmup = WARMUP * 2,
                                       thin = THIN * 2))

RDATA[["mcmcdb_nile_normal_2"]] <-
  mcmcdb_wide_from_stan(run_stan_model(STAN_MODELS["local_level_normal_reg"],
                                       data = nile_data, seed=SEED,
                                       iter = ITER,
                                       warmup = WARMUP,
                                       thin = THIN))


library("KFAS")
sampler_local_lvl <- function(H, Q, ...) {
  model <- SSModel(nile$flow,
                   Z = matrix(1),
                   H = H,
                   T = matrix(1),
                   Q = Q,
                   a1 = nile_data$a1,
                   P1 = nile_data$P1)
  as.numeric(simulateSSM(model, "state")[["states"]])
}
alpha <- mcmcdb_samples_iter(RDATA[["mcmcdb_nile_normal_1"]],
                             FUN = gsplat(sampler_local_lvl),
                             return_type = "a")
plot(nile$flow); points(apply(alpha, 2, mean), type="l"); points(apply(alpha, 2, quantile, prob=0.975), type="l"); points(apply(alpha, 2, quantile, prob=0.025), type="l")

sampler_local_lvl_hp <- function(H, Q, ...) {
  model <- SSModel(nile$flow,
                   Z = matrix(1),
                   H = H,
                   T = matrix(1),
                   Q = array(as.numeric(Q), c(1, 1, length(Q))),
                   a1 = nile_data$a1,
                   P1 = nile_data$P1)
  as.numeric(simulateSSM(model, "state")[["states"]])
}
alpha <- mcmcdb_samples_iter(RDATA[["mcmcdb_nile_hp"]],
                             FUN = splat(sampler_local_lvl_hp),
                             return_type = "a")
plot(nile$flow); points(apply(alpha, 2, mean), type="l"); points(apply(alpha, 2, quantile, prob=0.975), type="l"); points(apply(alpha, 2, quantile, prob=0.025), type="l")

sampler_local_lvl_normal_2 <- function(H, Q, cc, ...) {
  model <- SSModel(nile$flow - as.numeric(cc),
                   Z = matrix(1),
                   H = matrix(H),
                   T = matrix(1),
                   Q = matrix(Q),
                   a1 = nile_data$a1,
                   P1 = nile_data$P1)
  as.numeric(simulateSSM(model, "state")[["states"]]) + as.numeric(cc)
}
alpha <- mcmcdb_samples_iter(RDATA[["mcmcdb_nile_normal_2"]],
                             FUN = splat(sampler_local_lvl_normal_2),
                             return_type = "a")

plot(nile$flow); points(apply(alpha, 2, mean), type="l"); points(apply(alpha, 2, quantile, prob=0.975), type="l"); points(apply(alpha, 2, quantile, prob=0.025), type="l")
