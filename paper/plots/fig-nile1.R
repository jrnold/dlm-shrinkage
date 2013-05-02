OUTFILE <- commandArgs(TRUE)[1]
source("conf.R")

data(Nile)
nile <-
  data.frame(year = tsp(Nile)[1]:tsp(Nile)[2],
             flow = as.numeric(Nile))

nile_yhat <-
  melt(data.frame(year = nile$year,
                  normal = RDATA[["summary_nile"]][["normal"]][["yhat"]],
                  horseshoe = RDATA[["summary_nile"]][["hs"]][["yhat"]]),
       id.vars = "year")

gg <- (ggplot(nile, aes(x = year))
       + geom_point(aes(y = flow))
       + geom_line(aes(y = value, colour = variable), data = nile_yhat)
       + scale_y_continuous("Annual Flow")
       + theme_local())
ggsave(plot = gg, file = OUTFILE, height = 3.5, width = 5.5)

