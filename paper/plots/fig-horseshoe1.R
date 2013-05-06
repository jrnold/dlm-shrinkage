source("conf.R")
OUTFILE <- commandArgs(TRUE)[1]

x <- seq(-3.5, 3.5, by=0.1)
hp <- dhp(x)
hp[is.infinite(hp)] <- NA

dist <- melt(data.frame(x = x,
                        horseshoe = hp,
                        normal = dnorm(x),
                        cauchy = dcauchy(x),
                        laplace = dlaplace(x)),
             id.vars = c("x", "horseshoe"))

gg1 <- (ggplot(dist, aes(x = x, y = value))
        + facet_grid(. ~ variable)
        + geom_line(aes(y = value), colour = "gray50")
        + geom_line(aes(y = horseshoe), colour = "black")
        + theme_minimal(base_size = 10)
        + scale_x_continuous("x")
        + scale_y_continuous("p(x)"))
ggsave(plot = gg1, file = OUTFILE, width=5, height = 3)
       
