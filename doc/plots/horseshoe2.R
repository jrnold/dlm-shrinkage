library(ggplot2)
library(reshape2)
library(VGAM)

# Approximation of horseshoe density
# Theorem 1 of Carvallo et al.
dhp <- function(x) {
  K <- 1 / sqrt(2 * pi^3)
  lb <- (K / 2) * log(1 + 4 / x^2)
  ub <- K * log(1 + 2 / x^2)
  (lb + ub) / 2
}

x2 <- seq(3, 8, by=0.1)
dist2 <- melt(data.frame(x = x2,
                        horseshoe = dhp(x2),
                        normal = dnorm(x2),
                        cauchy = dcauchy(x2),
                        laplace = dlaplace(x2)),
             id.vars = "x")

gg2 <- (ggplot(dist2, aes(x = x, y = value, linetype=variable))
        + geom_line()
        + theme_gray(base_size = 10)
        + scale_x_continuous("Density")
        + scale_y_continuous("alpha")
        + scale_linetype_discrete("")
        + theme(legend.position = "bottom")
        + guides(linetype = guide_legend(nrow=2)))
ggsave(plot = gg2, file = "horseshoe2.pdf",
       width=2.5, height = 2.5)
