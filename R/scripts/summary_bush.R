set.seed(09532769)
bush <- RDATA[["bush_approval"]]

# Summaries of the Nile models
modelk <- c("hs", "normal")
models <- sprintf("mcmcdb_bush_%s", modelk)

summaries <- 
  llply(models,
        function(k, y) summary(RDATA[[k]], y), y = bush$approval)
names(summaries) <- modelk

RDATA[["summary_nile"]] <- summaries
