# ---
# data: icasualties/afghanistan_coalition_fatalities_by_year_month.csv
# ---
#
# Coalition Fatalities by year / month (9/2001 to 5/2013)
# in Operatation Enduring Freedom.
# 
#
# Source: http://icasualties.org/oef/

fatalities <- read.csv(DATA_FILE("icasualties/afghanistan_coalition_fatalities_by_year_month.csv"))

fatalities_m <-
  subset(mutate(melt(fatalities, c("year", "total"),
                     variable.name = "month",
                     value.name = "fatalities"),
                date = as.Date(sprintf("%s-%s-1", year, month), "%Y-%b-%d")),
         date >= as.Date("2001-9-1") & date < as.Date("2013-6-1"))

RDATA[["afghanistan_fatalities"]] <- fatalities_m
