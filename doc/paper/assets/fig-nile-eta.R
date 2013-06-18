# RDATA: mcmcsummary_nile_normal_2
# LOCAL: .nile_fit_plot.R
FILE <- commandArgs(TRUE)[1]
source("conf.R")

LATEX_NILE_MODELS <-
  c(nile_hs = "\\Model{nile}{hs}",
    nile_normal_1 = "\\Model{nile}{normal}",
    nile_normal_2 = "\\Model{nile}{inter}")

PLAIN_NILE_MODELS <-
  c(nile_hs = "M(nile, hs)",
    nile_normal_1 = "M(nile, normal)",
    nile_normal_2 = "M(nile, inter)")


eta <- ldply(sprintf("nile_%s", c("hs", "normal_1", "normal_2")),
             function(k) {
               key <- sprintf("mcmcsummary_%s", k)
               x <- melt(RDATA[[key]][["dist_state"]])
               ret <- data.frame(ddply(x, "Var2",
                                       function(df) mcmc3valsummary(df$value)),
                                 model = unname(LATEX_NILE_MODELS[k]))
               ret$year <- RDATA[["nile"]][["year"]]
               ret
             })

gg <- (ggplot(eta, aes(x = year, y = mean, ymin = lb, ymax = ub))
       + geom_pointrange()
       + facet_grid(model ~ .)
       + theme_local())
ggsave(plot = gg, file = FILE,
       height = 8, width = 5)
