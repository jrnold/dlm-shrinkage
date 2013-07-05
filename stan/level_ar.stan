data {
  int n;
  int ar;
  matrix[1, ar + 1] Z;
  matrix[ar + 1, 2] R;
  matrix[1 + ar, 1 + ar] T0;
  vector[1] c;
  vector[ar + 1] d;
  real<lower=0.0> P1_1;
  real a1_1;
  matrix[1, n] y;
}
transformed data {
  vector[ar + 1] a1;
  a1[1] <- a1_1;
  for (i in 1:ar) {
    a1[i + 1] <- 0.0;
  }
}
parameters {
  real<lower=0.0> sigma2;
  vector<lower=0.0>[2] tau;
  vector[ar] rho;
  real<lower=0.0> rho_pr_scale;
}
transformed parameters {
  vector<lower=0.0>[1] H;
  matrix[rows(T0), cols(T0)] T;
  matrix<lower=0.0>[2, 2] Q;
  vector<lower=0.0>[ar + 1] P1_diag;
  matrix[ar + 1, ar + 1] P1;
  H[1] <- sigma2;
  T <- T0;
  for (i in 1:ar) {
    T[2, i + 1] <- rho[i];
  }
  {
    vector[2] tau2;
    for (i in 1:2) {
      tau2[i] <- pow(tau[i], 2);
    }
  }
  Q <- diag_matrix(tau);
  P1_diag[1] <- P1_1;
  for (i in 1:ar) {
    P1_diag[i + 1] <- 1e7;
  }
  P1 <- diag_matrix(P1_diag);
}
model {
  matrix[ar + 1, ar + 1] RQR;
  RQR <- R * Q * R';
  { real KALMAN_SEQ_v; vector[rows(T)] KALMAN_SEQ_K; real KALMAN_SEQ_Finv; vector[rows(T)] KALMAN_SEQ_a; matrix[rows(T), rows(T)] KALMAN_SEQ_P; vector[rows(T)] KALMAN_SEQ_M; real KALMAN_SEQ_F; KALMAN_SEQ_a <- a1; KALMAN_SEQ_P <- P1; for (i in 1:cols(y)) { for (j in 1:rows(y)) { vector[rows(T)] KALMAN_SEQ_Zj; KALMAN_SEQ_Zj <- Z[j] '; KALMAN_SEQ_v <- y[j, i] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M '; KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P '); lp__ <- lp__ - 0.5 * (log(2 * pi()) + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); } KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T ' + RQR; KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P '); } };
  lp__ <- lp__ - log(sigma2);;
  tau ~ cauchy(0, sqrt(sigma2));
  for (i in 1:ar) {
    rho ~ normal(0, rho_pr_scale / i);
  }
}
