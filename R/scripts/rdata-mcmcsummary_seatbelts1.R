# ---
# filehash: mcmcdb_seatbelts1
# ---
set.seed(0843210321)
KEY <- "seatbelts1"
MCMCDB <- sprintf("mcmcdb_%s", KEY)
MCMCSUMMARY <- sprintf("mcmcsummary_%s", KEY)
RDATA[[MCMCSUMMARY]] <- bsdlm_summary(RDATA[[MCMCDB]], .parallel=TRUE)
