# RDATA: mcmcsummary_nile_normal_2
# LOCAL: .nile_fit_plot.R
FILE <- commandArgs(TRUE)[1]
source("conf.R")

eta <- ldply(c("hs", "normal_1", "normal_2"),
             function(k) {
               key <- sprintf("mcmcsummary_nile_%s", k)
               x <- melt(RDATA[[key]][["dist_state"]])
               ret <- data.frame(ddply(x, "Var1",
                                       function(df) mcmc3valsummary(df$value)),
                                 model = k)
               ret$year <- RDATA[["nile"]][["year"]]
               ret
             })

gg <- (ggplot(eta, aes(x = year, y = mean, ymin = lb, ymax = ub))
       + geom_pointrange()
       + facet_grid(model ~ .)
       + theme_local())
ggsave(plot = gg, file = FILE,
       height = 8, width = 5)
