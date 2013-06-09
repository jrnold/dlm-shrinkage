nile_fit_plot <- function(key, file) {
  alpha <- RDATA[[key]][["alpha"]]
  nile <- RDATA[["nile"]]
  
  alpha_m <- ddply(melt(alpha), "Var1",
                   summarise,
                   mean = mean(value),
                   lb = quantile(value, prob = 0.025),
                   ub = quantile(value, prob = 0.975))
  alpha_m[["year"]] <- nile[["year"]]
  
  gg <- (ggplot()
         + geom_point(data = nile, aes(x = year, y = flow, shape=dam))
         + geom_ribbon(data = alpha_m, aes(x = year, ymin = lb, ymax = ub),
                       alpha = 0.4)
         + geom_line(data = alpha_m, aes(x = year, y = mean))
         + scale_x_continuous("")
         + theme_local()
         + theme(legend.position = "none"))
  
  ggsave(filename = file, plot = gg,
         height = 2.67, width = 6)
}
