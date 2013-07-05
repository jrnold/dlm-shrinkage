# ---
# rdata: mcmcdb_afghan_2
# ---
KEY <- "afghan_2"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]], parallel=TRUE)
