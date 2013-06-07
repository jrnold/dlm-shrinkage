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
RDATA[[SUMMARY_KEY]] <- summary(RDATA[[MCMCDB_KEY]])

object <- RDATA[[MCMCDB_KEY]]

## summary.DlmLocalLevelNormal <- function(object, data) {
##   ret <- list()

##   y <- mcmcdb_data(object)$y
##   alpha <- ssm_sim(object, mcmcdb_data(object))
##   ret[["alpha"]] <- alpha
##   ret[["mu"]] <- alpha
##   f_yrep <- function(alpha, H, ...) {
##     alpha <- unlist(alpha)
##     n <- length(alpha)
##     rnorm(n, alpha, sqrt(H))
##   }
##   yrep <-
##     simplify2array(mlply(data.frame(alpha = I(alply(alpha, 1, identity)),
##                                     H = as.numeric(object[["H"]])),
##                          f_yrep))
##   ret[["yrep"]] <- yrep

##   f_loglik <- function(alpha, H, y) {
##     alpha <- unlist(alpha)
##     n <- length(alpha)
##     dnorm(y, alpha, sqrt(H), log = TRUE)
##   }
##   loglik <-
##     simplify2array(mlply(data.frame(alpha = I(alply(alpha, 1, identity)),
##                                     H = as.numeric(object[["H"]])),
##                          f_loglik, y = mcmcdb_data(object)$y))
##   ret[["loglik"]] <- loglik
##   ret[["eta"]] <- aaply(cbind(mcmcdb_data(object)$a1, alpha), 1, diff)
##   ret[["yhat"]] <- apply(yrep, 1, mean)
##   ret[["yvar"]] <- apply(yrep, 1, var)
##   ret[["lppd"]] <- log(apply(exp(ret[["loglik"]]), 1, mean))
##   ret[["waic"]] <- waic(ret[["loglik"]])
##   ret[["mse"]] <- discrepancy(y, yrep, "mse")
##   ret[["chisq"]] <- discrepancy(y, yrep, "chisq")
##   ret
## }

## setMethod("summary", "DlmLocalLevelNormal",
##           summary.DlmLocalLevelNormal)
