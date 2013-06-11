^# depends: $(RDATA_DIR)/mcmcdb_nile_normal_1
KEY <- "nile_normal_1"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]])
  
