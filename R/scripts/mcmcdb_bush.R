
bush_approval <- RDATA[["bush_approval"]]
min_date <- min(bush_approval[["date"]])
max_date <- max(bush_approval[["date"]])

bush_approval_2 <- merge(data.frame(date = seq(min_date, max_date, 1)),
                       bush_approval, all.x = TRUE)
struct_ts <- StructTS(bush_approval_2$approve)

SEED <- c(64425843)
ITER <- 2^12
WARMUP <- 2^11
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

y <- bush_approval_2$approve
missing <- is.na(y)
y[missing] <- 0

standata <- list(n = length(y),
                 missing = missing,
                 y = y,
                 a1 = y[1],
                 P1 = 25)

init <- list()
init$bush_normal <- list(H = struct_ts$coef['epsilon'],
                         tau = struct_ts$coef['level'] / struct_ts$coef['epsilon'])
init$bush_hp <- within(init$bush_normal, { lambda = rep(1, length(y)) })

RDATA[["mcmcdb_bush_normal_1"]] <- 
  mcmcdb_wide_from_stan(run_stan_model(STAN_MODELS["local_level_normal"],
                                       data = standata, seed=SEED, init = init$bush_normal,
                                       iter = ITER, warmup = WARMUP, thin = THIN))

RDATA[["mcmcdb_bush_hp_1"]] <- 
  mcmcdb_wide_from_stan(run_stan_model(STAN_MODELS["local_level_hp"],
                                       data = standata, seed=SEED, init = init$bush_hp,
                                       iter = ITER * 2, warmup = WARMUP * 2, thin = THIN * 2))


sampler_local_lvl <- function(H, Q, ...) {
  newy <- standata$y
  newy[as.logical(standata$missing)] <- NA
  model <- SSModel(y = newy,
                   Z = matrix(1),
                   H = H,
                   T = matrix(1),
                   Q = Q,
                   a1 = standata$a1,
                   P1 = standata$P1)
  as.numeric(simulateSSM(model, "state")[["states"]])
}
alpha <- mcmcdb_samples_iter(RDATA[["mcmcdb_bush_normal_1"]],
                             FUN = splat(sampler_local_lvl),
                             return_type = "a")

sampler_local_hp <- function(H, Q, ...) {
  newy <- standata$y
  newy[as.logical(standata$missing)] <- NA
  model <- SSModel(y = newy,
                   Z = matrix(1),
                   H = H,
                   T = matrix(1),
                   Q = array(as.numeric(Q), c(1, 1, length(Q))),
                   a1 = standata$a1,
                   P1 = standata$P1)
  as.numeric(simulateSSM(model, "state")[["states"]])
}
alpha <- mcmcdb_samples_iter(RDATA[["mcmcdb_bush_hp_1"]],
                             FUN = splat(sampler_local_hp),
                             return_type = "a")

plot(bush_approval_2$approve); points(apply(alpha, 2, mean), type="l"); points(apply(alpha, 2, quantile, prob=0.975), type="l"); points(apply(alpha, 2, quantile, prob=0.025), type="l")
