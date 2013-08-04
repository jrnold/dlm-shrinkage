# ---
# filehash: mcmcdb_seatbelts2
# ---
set.seed(0843210321)
KEY <- "seatbelts2"
MCMCDB <- sprintf("mcmcdb_%s", KEY)
MCMCSUMMARY <- sprintf("mcmcsummary_%s", KEY)
RDATA[[MCMCSUMMARY]] <- bsdlm_summary(RDATA[[MCMCDB]], .parallel=TRUE)
