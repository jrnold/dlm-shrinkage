# ---
# rdata: mcmcdb_bush_normal
# ---
KEY <- "bush_normal"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]], parallel=TRUE)
