source("conf.R")
OUTFILE <- commandArgs(TRUE)[1]

FUN <- function(key) {
  states <- laply(RDATA[[sprintf("mcmcsummary_nile_%s", key)]][["sample"]], as.numeric)
  nile <- RDATA[["nile"]]
  
  states_m <- ddply(melt(states), "Var2",
                    function(df) mcmc3valsummary(df$value))
  states_m <- states_m[-1, ]
  states_m[["year"]] <- nile[["year"]]
  states_m[["model"]] <- key
  states_m
}

keys <- c("hs", "normal_1", "normal_2")
foo <- ldply(keys, FUN)
foo$model <- factor(foo$model, levels = c("normal_1", "normal_2", "hs"))

gg <- (ggplot()
       + geom_ribbon(data = foo, aes(x = year, ymin = lb, ymax = ub),
                     alpha = 0.1)
       + geom_line(data = foo, aes(x = year, y = mean), size = rel(1.5))
       + geom_point(data = RDATA[["nile"]], aes(x = year, y = flow))
       + facet_grid(model ~ .)
       + scale_y_continuous("Annual flow")
       + scale_x_continuous("")
       + theme_local())

ggsave(filename = OUTFILE, plot = gg, height = 12, width = 7)
