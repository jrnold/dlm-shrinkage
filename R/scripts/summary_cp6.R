# Depends: cp6 mcmcdb_cp6_normal mcmcdb_cp6_hs mcmcdb_cp6_hs2 mcmcdb_cp6_hs4 
# Keys: summary_cp6
set.seed(09781350)

# Summaries of the Nile models
modelk <- c("normal", "hs", "hs2", "hs4")
models <- sprintf("mcmcdb_cp6_%s", modelk)

cp6 <- RDATA[["cp6"]]

summaries <- 
  llply(models,
        function(k, y) summary(RDATA[[k]], y), y = cp6$flow)
names(summaries) <- modelk

RDATA[["summary_cp6"]] <- summaries
