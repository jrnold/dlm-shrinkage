nile <- RDATA[["nile"]]
source(".nile_data.R")

n <- nile_data[["n"]]
Q_a <- rep(0, n)
Q_a[28] <- 10e6
nile_data[["Q_a"]] <- Q_a
nile_data[["Q_b"]] <- rep(1, n)
nile_data[["H_a"]] <- rep(0, n)
nile_data[["H_b"]] <- rep(1, n)


KEY <- "nile_normal_2"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

MODEL <- "local_level_normal_inter"

init <- list(sigma2 = 15099, tau = sqrt(1427))

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

RDATA[[MCMCDB_KEY]] <- new("DlmLocalLevelNormalInter", res)
