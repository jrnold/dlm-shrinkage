OUTFILE <- commandArgs(TRUE)[1]
source("conf.R")

data(Nile)
nile <-
  data.frame(year = tsp(Nile)[1]:tsp(Nile)[2],
             flow = as.numeric(Nile))

outliers <-
  data.frame(year = nile$year,
             w = RDATA[["summary_nile"]][["hs"]][["w"]])

gg <- (ggplot(outliers[-1, ], aes(x = year, y = w))
       + geom_point()
       + geom_hline(yintercept = 0.5, colour = "gray")
       + scale_y_continuous(expression(w[i] == 1 - E(hat(kappa[i]))))
       + theme_local())

ggsave(plot = gg, file = OUTFILE, height = 3.5, width = 5.5)
