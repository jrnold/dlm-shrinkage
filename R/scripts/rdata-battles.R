dtmean <- function(x, y) {
  as.POSIXct((as.numeric(x) + as.numeric(y)) / 2,
             origin = as.Date("1970-1-1"))
}

todt <- function(x) {
  ISO8601 <- "%Y-%m-%dT%H:%M:%S"
  as.POSIXct(x, format=ISO8601, tz = "GMT")
}

logp1 <- function(x) log(x + 1)

main <- function() {
  battles <- read.csv(file.path(ROOT_DIR, "lib", "CDB13", "data", "battles.csv"))
  combatants <- read.csv(file.path(ROOT_DIR, "lib", "CDB13", "data", "combatants.csv"))
  atp <- read.csv(file.path(ROOT_DIR, "lib", "CDB13",
                            "data", "active_periods.csv"),
                  stringsAsFactors = FALSE)
  duration <- ddply(atp, "isqno", summarise,
                    duration = sum((duration_min + duration_max) / 2) / 1440)
  
  casualties <- mutate(dcast(melt(combatants, id.vars = c("isqno", "attacker"),
                                  measure.vars = c("str", "cas")),
                             isqno ~ variable + attacker, value.var = "value"),
                       log_cas_ratio = logp1(cas_TRUE) - logp1(cas_FALSE),
                       log_str_ratio = logp1(str_TRUE) - logp1(str_FALSE))
  
  battles <- Reduce(merge,
                    list(battles[ , c("isqno", "name", "bdb_war", "bdb_theater")],
                         casualties,
                         duration))

  RDATA[["battles"]] <- battles
  
}      
