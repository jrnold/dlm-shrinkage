# ---
# rdata: greenbacks
# --- 
greenbacks <- RDATA[["greenbacks"]]
greenbacks_cw <- na.omit(subset(greenbacks, date <= as.Date("1865-6-1")))

greenbacks_cw_wday <- function(w) {
  subset(greenbacks_cw, wday(date) == w)
}
