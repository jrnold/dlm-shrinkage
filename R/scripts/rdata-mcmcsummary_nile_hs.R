# ---
# rdata: mcmcdb_nile_hs
# ---
KEY <- "nile_hs"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]])
  
