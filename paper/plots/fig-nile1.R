mcmcsummary_nile_hs <- RDATA[["mcmcsummary_nile_normal_2"]]

alpha <- mcmcsummary_nile_hs[["alpha"]]
alpha_m <- ddply(melt(alpha), "Var1",
                 summarise, mean = mean(value),
                 lb = quantile(value, prob = 0.025),
                 ub = quantile(value, prob = 0.975))

ggplot(alpha_m, aes(x = Var1, y = mean, ymin = lb, ymax = ub)) + geom_line() + geom_ribbon(alpha = 0.66)


mcmcdb_nile_hs <- RDATA[["mcmcdb_nile_hs"]]

lambda <- ddply(melt(mcmcdb_nile_hs[["lambda"]]), "Var1",
                function(x) {
                  hpd <- hpd_interval(x$value, 0.95)
                  data.frame(mean = mean(x$value),
                             lb = hpd[1],
                             ub = hpd[2])
                })

ggplot(lambda, aes(x = Var1, y = mean, ymin = lb, ymax = ub)) + geom_pointrange() + geom_hline(yintercept = 1, colour="gray")


dist_state <- ddply(melt(mcmcsummary_nile_hs[["dist_state"]]), "Var1",
                    function(x) {
                      hpd <- hpd_interval(x$value, 0.95)
                      data.frame(mean = mean(x$value),
                                 lb = hpd[1],
                                 ub = hpd[2])
                    })

ggplot(dist_state, aes(x=Var1, y = mean, ymin = lb, ymax = ub)) + geom_pointrange() + geom_hline(yintercept = 0, colour = "gray")



