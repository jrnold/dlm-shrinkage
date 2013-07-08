data {
  int n;
  int p;
  int m;
  int r;
  cov_matrix[m] P1;
  vector[m] a1;
  matrix[1, n] y;
  matrix[m, m] T;
  matrix[p, m] Z;
  matrix[m, r] R;
  vector[p] c;
  vector[m] d;
}
parameters {
  real<lower=0.0> sigma2;
  vector<lower=0.0>[2] tau;
  vector<lower=0.0>[n] lambda;
}
transformed parameters {
  matrix[r, r] Q[n];
  vector<lower=0.0>[p] H;
  H[1] <- sigma2;
  for (i in 1:n) {
    real tau2_2;
    vector<lower=0.0>[r] Q_diag;
    tau2_2 <- pow(tau[2], 2);
    Q_diag[1] <- pow(tau[1] * lambda[i], 2);
    Q_diag[2] <- tau2_2;
    Q_diag[3] <- tau2_2;
    Q[i] <- diag_matrix(Q_diag);
  }
}
model {
  matrix[r, r] RQR[n];
  for (i in 1:n) {
    RQR[i] <- R * Q[i] * R';
  }
  { real KALMAN_SEQ_v; vector[rows(T)] KALMAN_SEQ_K; real KALMAN_SEQ_Finv; vector[rows(T)] KALMAN_SEQ_a; matrix[rows(T), rows(T)] KALMAN_SEQ_P; vector[rows(T)] KALMAN_SEQ_M; real KALMAN_SEQ_F; KALMAN_SEQ_a <- a1; KALMAN_SEQ_P <- P1; for (i in 1:cols(y)) { for (j in 1:rows(y)) { vector[rows(T)] KALMAN_SEQ_Zj; KALMAN_SEQ_Zj <- Z[j] '; KALMAN_SEQ_v <- y[j, i] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M '; KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P '); lp__ <- lp__ - 0.5 * (log(2 * pi()) + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); } KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T ' + RQR[i]; KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P '); } };
  lp__ <- lp__ - log(sigma2);;
  tau ~ cauchy(0, sqrt(sigma2));
  lambda ~ cauchy(0, 1);
}