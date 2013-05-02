source("conf.R")
library(VGAM)

OUTFILE <- commandArgs(TRUE)[1]

x <- seq(-3.5, 3.5, by=0.1)
hp <- dhp(x)
hp[is.infinite(hp)] <- NA

dist <- melt(data.frame(x = x,
                        horseshoe = hp,
                        normal = dnorm(x),
                        cauchy = dcauchy(x),
                        laplace = dlaplace(x)),
             id.vars = "x")

gg1 <- (ggplot(dist, aes(x = x, y = value, linetype=variable))
        + geom_line()
        + theme_local(base_size = 10)
        + scale_x_continuous("Density")
        + scale_y_continuous("alpha")
        + scale_linetype_discrete("")
        + guides(linetype = guide_legend(nrow=2)))

ggsave(plot = gg1, file = OUTFILE, width=2.5, height = 2.5)
       
