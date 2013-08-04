
# ---
# filehash: mcmcdb_seatbelts3
# ---
set.seed(28607416)
KEY <- "seatbelts3"
MCMCDB <- sprintf("mcmcdb_%s", KEY)
MCMCSUMMARY <- sprintf("mcmcsummary_%s", KEY)
RDATA[[MCMCSUMMARY]] <- bsdlm_summary(RDATA[[MCMCDB]], .parallel=TRUE)

