# RDATA: mcmcsummary_nile_normal_2
# LOCAL: .nile_fit_plot.R
FILE <- commandArgs(TRUE)[1]
source("conf.R")

mcmcdb_nile_hs <- RDATA[["mcmcdb_nile_hs"]]
lambda <- ddply(melt(mcmcdb_nile_hs[["lambda"]]), "Var1",
                function(df) data.frame(median = median(df$value)))
lambda[["year"]] <- RDATA[["nile"]][["year"]]

gg <- (ggplot(lambda, aes(x = year, y = median))
       + geom_point()
       + geom_hline(yintercept = 1, colour="gray")
       + theme_local())
ggsave(plot = gg, file = FILE, height = 2.75, width = 6)
