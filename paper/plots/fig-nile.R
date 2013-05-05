source("conf.R")
OUTFILE <- commandArgs(TRUE)[1]
nile <- RDATA[["nile"]]

nile_yhat <-
  melt(mutate(nile,
              dam = NULL,
              normal = RDATA[["summary_nile"]][["normal"]][["yhat"]],
              normal2 = RDATA[["summary_nile"]][["normal2"]][["yhat"]],
              horseshoe = RDATA[["summary_nile"]][["hs"]][["yhat"]]),
       id.vars = c("year", "flow"))

gg <- (ggplot(nile_yhat, aes(x = year))
       + facet_grid(variable ~ . )
       + geom_point(aes(y = flow), colour = "gray")
       + geom_line(aes(y = value))
       + scale_y_continuous("Annual Flow")
       + scale_colour_manual(values = c("gray", "black"))
       + theme_local())

ggsave(plot = gg, file = OUTFILE, height = 8, width = 5.5)
