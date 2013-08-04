seatbelt_fit_plot <- function(key, file) {
  states <- laply(RDATA[[key]][["sample"]], function(x) x[ , 2])
  states <- laply(RDATA[[key]][["yrep"]], as.numeric)
  states_m <- ddply(melt(states), "Var2",
                    function(df) mcmc3valsummary(df$value))
  states_m <- states_m[-1, ]
  
  gg <- (ggplot()
         + geom_ribbon(data = states_m, aes(x = Var2, ymin = lb, ymax = ub),
                       states = 0.4)
         + geom_line(data = states_m, aes(x = Var2, y = mean))
         + scale_x_continuous("")
         + theme_local()
         + theme(legend.position = "none"))
  
  ggsave(filename = file, plot = gg,
         height = 2.67, width = 6)
}
