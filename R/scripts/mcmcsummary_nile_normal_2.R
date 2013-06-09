KEY <- "nile_normal_2"
RDATA[[sprintf("mcmcsummary_%s", KEY)]] <- mcmcsummary(RDATA[[sprintf("mcmcdb_%s", KEY)]])
