greenbacks <- RDATA[["greenbacks"]]

greenbacks_4 <- subset(greenbacks,
                       wday(date) == 4 && date < 
