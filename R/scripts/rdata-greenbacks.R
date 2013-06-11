# depends: $(DATA_DIR)/greenbacks.csv
greenbacks <-
  mutate(read.delim(DATA_FILE("greenbacks.csv")),
         date = as.Date(dt, "%Y-%m-%d"),
         dt = NULL,
         lhigh = log(high),
         llow = log(low),
         lmean = 0.5 * (lhigh + llow),
         lsd = sqrt((1 / 12) * (lhigh - llow)^2))

RDATA[["greenbacks"]] <- greenbacks
