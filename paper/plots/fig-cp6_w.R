source("conf.R")
OUTFILE <- commandArgs(TRUE)[1]
cp6 <- RDATA[["cp6"]]

outliers <-
  data.frame(date = cp6$date,
             w = RDATA[["summary_cp6"]][["hs"]][["w"]])

gg <- (ggplot(outliers[-1, ], aes(x = date, y = w))
       + geom_point()
       + geom_hline(yintercept = 0.5, colour = "gray")
       + scale_y_continuous(expression(w[i] == 1 - E(hat(kappa[i]))))
       + theme_local())

ggsave(plot = gg, file = OUTFILE, height = 3.5, width = 5.5)
