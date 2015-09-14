library("dplyr")
CP6 <- read.csv("data-raw/CP6.csv") %>%
  mutate(date = as.Date(sprintf("%d-%d-01", year, month))) %>%
  select(date, sales)
devtools::use_data(CP6, overwrite = TRUE)

