source("conf.R")
OUTFILE <- commandArgs(TRUE)[1]

xd <- 0.005
x <- seq(0 + xd, 1 - xd, by = xd)

gg <- (ggplot(data.frame(x = x, y = dbeta(x, 0.5, 0.5)),
              aes(x = x, y = y))
       + geom_line()
       + scale_x_continuous(expression(delta[t]))
       + scale_y_continuous(expression(p(delta[t])))
       + theme_local())
ggsave(plot = gg, file = OUTFILE, height = 3, width = 5)

