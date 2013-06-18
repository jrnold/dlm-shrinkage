# ---
# rdata: mcmcdb_greenbacks1
# ---
KEY <- "greenbacks1"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]])
