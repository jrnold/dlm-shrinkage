data {
  int n;
  matrix[1, n] y;
  real<lower=0.0> meas_err[n];
  cov_matrix[3] P1;
  vector[3] a1;
}
transformed data {
  matrix[3, 2] R;
  matrix[1, 3] Z;
  vector[1] c;
  vector[3] d;
  int m;
  int r;
  int p;
  m <- 3;
  r <- 2;
  p <- 1;
  R[1, 1] <- 0;
  R[1, 1] <- 0;
  R[2, 1] <- 1;
  R[2, 2] <- 0;
  R[3, 1] <- 0;
  R[3, 2] <- 1;
  Z[1, 1] <- 1;
  Z[1, 2] <- 0;
  Z[1, 3] <- 1;
  c[1] <- 0;
  for (i in 1:3) {
    d[i] <- 0;
  }
}
parameters {
  vector<lower=0.0>[2] tau;
  real<lower=0.0> sigma2;
  real<lower=-1, upper=1> rho1;
  real<lower=-1, upper=1> rho2;
  vector<lower=0.0>[n] lambda;
}
transformed parameters {
  matrix[2, 2] T;
  vector<lower=0.0>[1] H[n];
  vector<lower=0.0>[2] Qdiag[n];
  matrix<lower=0.0>[2, 2] Q[n];
  T[1, 1] <- 1;
  T[1, 2] <- 1;
  T[1, 3] <- 0;
  T[2, 1] <- 0;
  T[2, 2] <- rho1;
  T[2, 3] <- 0;
  T[3, 1] <- 0;
  T[3, 2] <- 0;
  T[3, 3] <- rho2;
  for (i in 1:n) {
    H[i, 1] <- meas_err[i];
  }
  for (i in 1:n) {
    Qdiag[i, 1] <- pow(lambda[i] * tau[1], 2);
    Qdiag[i, 2] <- pow(tau[2], 2);
    Q[i] <- diag_matrix(Qdiag[i]);
  }
}
model {
  matrix[2, 2] RQR[n];
  for (i in 1:n) {
    RQR[i] <- R * Q[i] * R';
  }
  { real KALMAN_SEQ_v; vector[rows(T)] KALMAN_SEQ_K; real KALMAN_SEQ_Finv; vector[rows(T)] KALMAN_SEQ_a; matrix[rows(T), rows(T)] KALMAN_SEQ_P; vector[rows(T)] KALMAN_SEQ_M; real KALMAN_SEQ_F; KALMAN_SEQ_a <- a1; KALMAN_SEQ_P <- P1; for (i in 1:cols(y)) { for (j in 1:rows(y)) { vector[m] KALMAN_SEQ_Zj; KALMAN_SEQ_Zj <- Z[j] '; KALMAN_SEQ_v <- y[j, i] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M '; KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P '); lp__ <- lp__ - 0.5 * (log(2 * pi()) + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); } KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T ' + RQR[i]; KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P '); } };
  lp__ <- lp__ - log(sigma2);;
  tau ~ cauchy(0, 1);
  lambda ~ cauchy(0, 1);
}
