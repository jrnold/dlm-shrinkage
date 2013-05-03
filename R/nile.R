data(Nile)
nile <-
  mutate(data.frame(year = tsp(Nile)[1]:tsp(Nile)[2],
                    flow = as.numeric(Nile)),
         intervention = year >= 1899)
RDATA[["nile"]] <- nile
