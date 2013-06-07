nile <- RDATA[["nile"]]
source(".nile_data.R")

KEY <- "nile_normal_1"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

MODEL <- "local_level_normal"

init <- list(H = 15099, tau = sqrt(1469))

timing <-
  system.time(smpls <- run_stan_model(STAN_MODELS(MODEL),
                                      data = nile_data, seed=SEED,
                                      init = init,
                                      iter = ITER,
                                      warmup = WARMUP,
                                      thin = THIN))
res <- 
  mcmcdb_wide_from_stan(smpls,
                        model_data = nile_data,
                        model_name = MODEL)
res@metadata[["system_time"]] <- timing

RDATA[[MCMCDB_KEY]] <- new("DlmLocalLevelNormal", res)
#RDATA[[SUMMARY_KEY]] <- summary(RDATA[[MCMCDB_KEY]])

object <- RDATA[[MCMCDB_KEY]]

mcmcsummary <- function(object, data = mcmcdb_data(sim)) {
  ret <- list()

  sims <- ssm_sim(object)
  ret[["alpha"]] <- laply(sims, `[[`, i = "alpha") # iter x states
  ret[["yhat"]] <- laply(sims, `[[`, i = "yhat")
  ret[["yrep"]] <- laply(sims, `[[`, i = "yrep")
  ret[["loglik"]] <- laply(sims, `[[`, i = "loglik")
  
  ret[["eta"]] <- aaply(cbind(mcmcdb_data(object)$a1, alpha), 2, diff)
  ret[["yhat"]] <- apply(yrep, 1, mean)
  ret[["yvar"]] <- apply(yrep, 1, var)
  ret[["lppd"]] <- log(apply(exp(ret[["loglik"]]), 1, mean))
  ret[["waic"]] <- waic(ret[["loglik"]])
  ret[["mse"]] <- discrepancy(y, yrep, "mse")
  ret[["chisq"]] <- discrepancy(y, yrep, "chisq")
  ret
}

