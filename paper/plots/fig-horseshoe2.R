source("conf.R")
OUTFILE <- commandArgs(TRUE)[1]

x2 <- seq(3, 8, by=0.1)
dist2 <- melt(data.frame(x = x2,
                        horseshoe = dhp(x2),
                        normal = dnorm(x2),
                        cauchy = dcauchy(x2),
                        laplace = dlaplace(x2)),
              id.vars = c("x", "horseshoe"))

gg2 <- (ggplot(dist2, aes(x = x, y = value))
        + facet_grid(. ~ variable)
        + geom_line(aes(y = value), colour = "gray50")
        + geom_line(aes(y = horseshoe), colour = "black")
        + theme_local(base_size = 10)
        + scale_x_continuous("x")
        + scale_y_continuous("p(x)"))
ggsave(plot = gg2, file = OUTFILE, width=5, height = 3)
