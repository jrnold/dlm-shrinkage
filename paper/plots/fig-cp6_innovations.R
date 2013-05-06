source("conf.R")
OUTFILE <- commandArgs(TRUE)[1]

cp6 <- RDATA[["cp6"]]

innovations <-
  ldply(RDATA[["summary_cp6"]],
        function(x) {
          data.frame(
            date = cp6$date[-1],
            mean = apply(x[["innovations"]], 1, mean),
            p025 = x[["hpd95"]][1, ],
            p975 = x[["hpd95"]][2, ])
        })

gg <- (ggplot(innovations, aes(x=date, y=mean, ymin=p025, ymax=p975))
       + geom_point()
       + geom_linerange(colour = "gray")
       + facet_grid(.id ~ .)
       + theme_local())
ggsave(plot = gg, file = OUTFILE, height = 7, width = 6)
