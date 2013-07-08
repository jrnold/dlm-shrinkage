nile_data <-
  within(list(), {
    T <- nrow(nile)
    y <- t(nile$flow)
    m0 <- array(nile$flow[1])
    C0 <- matrix(var(nile$flow))
  })
