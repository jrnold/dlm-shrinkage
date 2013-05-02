source("conf.R")
library(VGAM)
OUTFILE <- commandArgs(TRUE)[1]

x2 <- seq(3, 8, by=0.1)
dist2 <- melt(data.frame(x = x2,
                        horseshoe = dhp(x2),
                        normal = dnorm(x2),
                        cauchy = dcauchy(x2),
                        laplace = dlaplace(x2)),
             id.vars = "x")

gg2 <- (ggplot(dist2, aes(x = x, y = value, linetype=variable))
        + geom_line()
        + theme_local(base_size = 10)
        + scale_x_continuous("Density")
        + scale_y_continuous("alpha")
        + scale_linetype_discrete("")
        + guides(linetype = guide_legend(nrow=2)))
ggsave(plot = gg2, file = OUTFILE, width=2.5, height = 2.5)
