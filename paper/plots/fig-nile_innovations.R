source("conf.R")
OUTFILE <- commandArgs(TRUE)[1]

nile <- RDATA[["nile"]]

innovations <-
  ldply(RDATA[["summary_nile"]],
        function(x) {
          data.frame(
            year = nile$year[-1],
            mean = apply(x[["innovations"]], 1, mean),
            p025 = x[["hpd95"]][1, ],
            p975 = x[["hpd95"]][2, ])
        })

gg <- (ggplot(innovations, aes(x=year, y=mean, ymin=p025, ymax=p975))
       + geom_point()
       + geom_linerange(colour = "gray")
       + facet_grid(.id ~ .)
       + theme_local())
ggsave(plot = gg, file = OUTFILE, height = 7, width = 6)
