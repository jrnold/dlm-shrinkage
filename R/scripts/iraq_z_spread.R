iraq_z_spread <- mutate(read.csv(DATA_FILE("iraq_z_spread.csv"),
                                 skip = 4),
                        date = as.Date(date, "%m/%d/%Y"))
RDATA[["iraq_z_spread"]] <- iraq_z_spread
