data {
  int n;
  int p;
  int m;
  int r;
  cov_matrix[m] P1;
  vector[m] a1;
  int y[n];
  matrix[m, m] T;
  matrix[p, m] Z;
  matrix[m, r] R;
  matrix[r, r] Q1;
  vector[p] c;
  vector[m] d;
}
transformed data {
}
parameters {
  matrix[p, n] mu;
  real<lower=0.0> sigma2;
  vector[r] tau2;
}
transformed parameters {
  cov_matrix[r] Q;
  vector<lower=0.0>[p] H;
  H[1] <- sigma2;
  Q <- Q1 * diag_matrix(tau2) * Q1';
}
model {
  matrix[m, m] RQR;
  RQR <- R * Q * R';
  { real KALMAN_SEQ_v; vector[rows(T)] KALMAN_SEQ_K; real KALMAN_SEQ_Finv; vector[rows(T)] KALMAN_SEQ_a; matrix[rows(T), rows(T)] KALMAN_SEQ_P; vector[rows(T)] KALMAN_SEQ_M; real KALMAN_SEQ_F; KALMAN_SEQ_a <- a1; KALMAN_SEQ_P <- P1; for (i in 1:cols(mu)) { for (j in 1:rows(mu)) { vector[m] KALMAN_SEQ_Zj; KALMAN_SEQ_Zj <- Z[j] '; KALMAN_SEQ_v <- mu[j, i] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M '; KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P '); lp__ <- lp__ - 0.5 * (log(2 * pi()) + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); } KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T ' + RQR; KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P '); } };
  for (i in 1:n) {
    y[i] ~ poisson(exp(mu[1, i]));
  }
  lp__ <- lp__ - log(sigma2);;
  tau2 ~ cauchy(0, sqrt(sigma2));
}
