# ---
# rdata: mcmcdb_afghan_1
# ---
KEY <- "afghan_1"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]], parallel=TRUE)
