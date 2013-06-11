# depends: $(RDATA_DIR)/mcmcdb_bush_spline_hs
KEY <- "bush_spline_hs"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <-
  mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]], parallel = TRUE)
