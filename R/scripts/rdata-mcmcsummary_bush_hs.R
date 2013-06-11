^# depends: $(RDATA_DIR)/mcmcdb_bush_hs
KEY <- "bush_hs"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]], parallel=TRUE)
