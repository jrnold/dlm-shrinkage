# RDATA: mcmcsummary_nile_normal_2
# LOCAL: .nile_fit_plot.R
FILE <- commandArgs(TRUE)[1]
source("conf.R")
source(".nile_fit_plot.R")
nile_fit_plot("mcmcsummary_nile_hs", FILE)

## mcmcdb_nile_hs <- RDATA[["mcmcdb_nile_hs"]]

## lambda <- ddply(melt(mcmcdb_nile_hs[["lambda"]]), "Var1",
##                 function(x) {
##                   hpd <- hpd_interval(x$value, 0.95)
##                   data.frame(mean = mean(x$value),
##                              lb = hpd[1],
##                              ub = hpd[2])
##                 })

## ggplot(lambda, aes(x = Var1, y = mean, ymin = lb, ymax = ub)) + geom_pointrange() + geom_hline(yintercept = 1, colour="gray")


## dist_state <- ddply(melt(mcmcsummary_nile_hs[["dist_state"]]), "Var1",
##                     function(x) {
##                       hpd <- hpd_interval(x$value, 0.95)
##                       data.frame(mean = mean(x$value),
##                                  lb = hpd[1],
##                                  ub = hpd[2])
##                     })

## ggplot(dist_state, aes(x=Var1, y = mean, ymin = lb, ymax = ub)) + geom_pointrange() + geom_hline(yintercept = 0, colour = "gray")

