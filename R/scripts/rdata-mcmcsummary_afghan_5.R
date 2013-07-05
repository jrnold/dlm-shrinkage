# ---
# rdata: mcmcdb_afghan_5
# ---
KEY <- "afghan_5"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]], parallel=TRUE)
