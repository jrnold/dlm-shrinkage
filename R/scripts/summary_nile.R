nile <- RDATA[["nile"]]
set.seed(09532769)

# Summaries of the Nile models
modelk <- c("normal", "normal2", "hs")
models <- sprintf("mcmcdb_nile_%s", modelk)

summaries <- 
  llply(models,
        function(k, y) summary(RDATA[[k]], y), y = nile$flow)
names(summaries) <- modelk

RDATA[["summary_nile"]] <- summaries
