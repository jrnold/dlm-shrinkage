# depends: $(RDATA_DIR)/mcmcdb_bush_spline
KEY <- "bush_spline"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]], parallel=TRUE)
