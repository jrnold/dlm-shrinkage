# ---
# rdata: mcmcdb_afghan_3
# ---
KEY <- "afghan_3"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]], parallel=TRUE)
