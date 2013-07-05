# ---
# rdata: mcmcdb_afghan_6
# ---
KEY <- "afghan_6"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]], parallel=TRUE)
