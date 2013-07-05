# ---
# rdata: mcmcdb_greenbacks2
# ---
KEY <- "greenbacks3"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]])

