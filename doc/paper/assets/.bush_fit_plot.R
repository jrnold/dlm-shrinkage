bush_fit_plot <- function(key, file) {
  alpha <- RDATA[[key]][["alpha"]]
  data <- RDATA[["bush_approval"]]
  
  alpha_m <- ddply(melt(alpha), "Var1",
                   function(df) mcmc3valsummary(df$value))
  alpha_m[["date"]] <- data[["date"]]
  
  gg <- (ggplot()
         + geom_point(data = data, aes(x = date, y = approve), size=0.5)
         + geom_ribbon(data = alpha_m, aes(x = date, ymin = lb, ymax = ub),
                       alpha = 0.4)
         + geom_line(data = alpha_m, aes(x = date, y = mean))
         + scale_x_date("")
         + theme_local()
         + theme(legend.position = "none"))
  
  ggsave(filename = file, plot = gg,
         height = 2.67, width = 6)
}
