library("dplyr")
BushApproval <- read.csv("data-raw/bush_approval.csv") %>%
  mutate(start_date = as.Date(start_date, "%m/%d/%Y"),
         end_date = as.Date(end_date, "%m/%d/%Y"))
use_data(BushApproval, overwrite = TRUE)
