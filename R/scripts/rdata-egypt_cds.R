# ---
# data: EGYPT_CDS_USD_SR.csv
# ---
egypt_cds <- read.csv(DATA_FILE("EGYPT_CDS_USD_SR.csv"),
                      skip = 2)[ , -1]
names(egypt_cds)[1] <- "date"
egypt_cds$date <- as.Date(egypt_cds$date, format="%m/%d/%y")
egypt_cds <- egypt_cds[!is.na(egypt_cds$date), ]
# data seeem weird before this date
egypt_cds <- subset(egypt_cds, date > as.Date("2009-8-11"))
egypt_cds <- arrange(egypt_cds, date)
RDATA[["egypt_cds"]] <- egypt_cds
