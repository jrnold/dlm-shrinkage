bush_approval <-
  mutate(read.csv("../../data/bush_approval.csv"),
         start_date = as.Date(start_date, "%m/%d/%Y"),
         end_date = as.Date(end_date, "%m/%d/%Y"),
         date = start_date + as.integer(end_date - start_date) / 2)
RDATA[["bush_approval"]] <- bush_approval
