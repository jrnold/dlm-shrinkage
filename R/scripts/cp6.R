# Depends:
# Keys: cp6
cp6 <- read.csv("../data/CP6.csv")
cp6[["date"]] <- as.Date(sprintf("%d-%d-1", cp6[["year"]], cp6[["month"]]))
RDATA[["cp6"]] <- cp6
