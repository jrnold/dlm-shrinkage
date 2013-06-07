nile <- RDATA[["nile"]]
source(".nile_data.R")

KEY <- "nile_normal_2"
MCMCDB_KEY <- sprintf("mcmcdb_%s", KEY)
SUMMARY_KEY <- sprintf("summary_%s", KEY)

SEED <- c(43542530304)
ITER <- 2^13
WARMUP <- 2^12
NSAMPLES <- 2^10
THIN <- (ITER - WARMUP) / NSAMPLES

MODEL <- "local_level_normal_reg"

init <- list(H = 15099, tau = sqrt(1469), beta = array(-250, 1))

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
RDATA[[MCMCDB_KEY]] <- new("DlmLocalLevelNormalReg", res)
