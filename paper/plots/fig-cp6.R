source("conf.R")
OUTFILE <- commandArgs(TRUE)[1]
cp6 <- RDATA[["cp6"]]

cp6_yhat <-
  melt(mutate(cp6,
              year = NULL,
              month = NULL,
              normal = RDATA[["summary_cp6"]][["normal"]][["yhat"]],
              hs = RDATA[["summary_cp6"]][["hs"]][["yhat"]],
              hs2 = RDATA[["summary_cp6"]][["hs2"]][["yhat"]],
              hs4 = RDATA[["summary_cp6"]][["hs4"]][["yhat"]]),
       id.vars = c("date", "sales"))

gg <- (ggplot(cp6_yhat, aes(x = date))
       + facet_grid(variable ~ . )
       + geom_point(aes(y = sales), colour = "gray")
       + geom_line(aes(y = value))
       + scale_y_continuous("Sales")
       + scale_colour_manual(values = c("gray", "black"))
       + theme_local())
ggsave(plot = gg, file = OUTFILE, height = 8, width = 5.5)
