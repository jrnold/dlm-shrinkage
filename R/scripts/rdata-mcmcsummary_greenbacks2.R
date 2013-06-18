# ---
# rdata: mcmcdb_greenbacks2
# ---
KEY <- "greenbacks2"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]])
