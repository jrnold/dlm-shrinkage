# ---
# rdata: mcmcdb_afghan_4
# ---
KEY <- "afghan_4"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]], parallel=TRUE)
