nile_fit_plot <- function(key, file) {
  states <- laply(RDATA[[key]][["sample"]], as.numeric)
  nile <- RDATA[["nile"]]
  
  states_m <- ddply(melt(states), "Var2",
                    function(df) mcmc3valsummary(df$value))
  states_m <- states_m[-1, ]
  states_m[["year"]] <- nile[["year"]]
  
  gg <- (ggplot()
         + geom_point(data = nile, aes(x = year, y = flow, shape=dam))
         + geom_ribbon(data = states_m, aes(x = year, ymin = lb, ymax = ub),
                       states = 0.4)
         + geom_line(data = states_m, aes(x = year, y = mean))
         + scale_x_continuous("")
         + theme_local()
         + theme(legend.position = "none"))
  
  ggsave(filename = file, plot = gg,
         height = 2.67, width = 6)
}
