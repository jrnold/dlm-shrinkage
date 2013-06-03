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

init <- list()
init$nile_normal_1 <-
  list(H = 15099, tau = 1469 / 15099)
init$nile_normal_2 <-
  c(init$nile_normal_1, list(beta = -249))
init$nile_hp_v2 <- 
  within(init$nile_normal_1, {
    lambda_tmp <- atan(rep(0.001, nile_data$n))
    lambda_tmp[28] <- atan(2.1)
  })
init$nile_hp_v1 <- 
  within(init$nile_normal_1, {
    lambda <- rep(0.001, nile_data$n)
    lambda[28] <- 2.1
  })



RDATA[["mcmcdb_nile_normal_1"]] <-
  mcmcdb_wide_from_stan(run_stan_model(STAN_MODELS["local_level_normal"],
                                       data = nile_data, seed=SEED,
                                       init = init$nile_normal_1,
                                       iter = ITER,
                                       warmup = WARMUP,
                                       thin = THIN))

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
                             FUN = splat(sampler_local_lvl),
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
