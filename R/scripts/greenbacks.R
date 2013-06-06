greenbacks <-
  mutate(read.delim("../../data/greenbacks.csv"),
         date = as.Date(dt, "%Y-%m-%d"),
         dt = NULL,
         lhigh = log(high),
         llow = log(low),
         lmean = 0.5 * (lhigh + llow),
         lsd = sqrt((1 / 12) * (lhigh - llow)^2))

RDATA[["greenbacks"]] <- greenbacks
