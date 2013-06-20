afghanistan_fatalities <- RDATA[["afghanistan_fatalities"]]

mod <- dlm::dlmModPoly(2) + dlm::dlmModSeas(12)

Z <- mod$FF
T <- mod$GG
R <- matrix(0, nrow(T), ncol(T))
diag(R)[1:3] <- 1
Q1 <- diag(3)
Q1[1, 2] <- 1L
Q1 %*% diag(3) %*% t(Q1)

standata <- within(list(), {
  y <- afghanistan_fatalities[["fatalities"]]
  n <- length(y)
  T <- T
  R <- R
  Q1 <- Q1
  p <- 1L
  m <- ncol(Z)
  r <- ncol(R)
})

