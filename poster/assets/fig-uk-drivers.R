source("conf.R")
OUTFILE <- commandArgs(TRUE)[1]

deaths <- 
  data.frame(
    deaths = log(as.numeric(UKDriverDeaths)),
    years = rep(seq(start(UKDriverDeaths)[1], end(UKDriverDeaths)[1], 1), each=12),
    months = 1:12)
deaths <- mutate(deaths, date = as.Date(sprintf("%d-%d-15", years, months)))

FUN <- function(key) {
  states <- laply(RDATA[[sprintf("mcmcsummary_%s", key)]][["sample"]],
                  function(x) x[ , 1])
  states_m <- ddply(melt(states), "Var2",
                    function(df) mcmc3valsummary(df$value))
  states_m <- states_m[-1, ]
  states_m[["model"]] <- key
  states_m[["date"]] <- deaths[["date"]]
  states_m
}

keys <- c("seatbelts1", "seatbelts2", "seatbelts3")
foo <- ldply(keys, FUN)
foo$model <- factor(foo$model, levels = c("seatbelts1", "seatbelts3", "seatbelts2"))


gg <- (ggplot()
       + geom_ribbon(data = foo, aes(x = date, ymin = lb, ymax = ub),
                     alpha = 0.1)
       + geom_line(data = foo, aes(x = date, y = mean), size = rel(1.5))
       + geom_point(data = deaths, aes(x = date, y = deaths))
       + facet_grid(model ~ .)
       + scale_x_date("")
       + theme_local())

ggsave(filename = OUTFILE, plot = gg,
       height = 12, width = 7)
