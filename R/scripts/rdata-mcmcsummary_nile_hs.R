# ---
# filehash: mcmcdb_nile_normal_2
# ---
set.seed(0843210321)
KEY <- "nile_normal_2"
MCMCDB <- sprintf("mcmcdb_%s", KEY)
MCMCSUMMARY <- sprintf("mcmcsummary_%s", KEY)
RDATA[[MCMCSUMMARY]] <- bsdlm_summary(RDATA[[MCMCDB]], .parallel=TRUE)
