battles <- read.csv(file.path(ROOT_DIR, "lib", "CDB13", "data", "battles.csv"))
combatants <- read.csv(file.path(ROOT_DIR, "lib", "CDB13", "data", "combatants.csv"))
atp <- read.csv(file.path(ROOT_DIR, "lib", "CDB13", "data", "active_periods.csv"))

logp1 <- function(x) log(x + 1)

foo <- mutate(dcast(melt(combatants, id.vars = c("isqno", "attacker"),
                         measure.vars = c("str", "cas")),
                    isqno ~ variable + attacker, value.var = "value"),
              log_cas_ratio = logp1(cas_TRUE) - logp1(cas_FALSE),
              log_str_ratio = logp1(str_TRUE) - logp1(str_FALSE))


ddply(durations, "isqno",
      function(x) {
        (start_time_min + start_time_max) / 2
      })
      
