nile_data <- list(n = nrow(nile),
                  y = nile$flow,
                  X = matrix(as.integer(nile$dam)),
                  k = 1L,
                  missing = rep(0L, length(nile$flow)),
                  a1 = nile$flow[1],
                  P1 = var(nile$flow))
