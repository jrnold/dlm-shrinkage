data {
  int n;
  matrix[1, 2] Z;
  matrix[2, 2] R;
  vector[1] c;
  vector[2] d;
  vector[2] a1;
  real<lower=0.0> P1_1;
  real rho_ub;
  real rho_lb;
  real rho_mean;
  real rho_sd;
  matrix[1, n] y;
  real<lower=0.0> meas_err[n];
}
parameters {
  real<lower=0.0> sigma2;
  vector<lower=0.0>[2] tau;
  real<lower=rho_lb, upper=rho_ub> rho;
}
transformed parameters {
  vector<lower=0.0>[1] H[n];
  matrix<lower=0.0>[2, 2] Q;
  matrix[2, 2] P1;
  vector<lower=0.0>[2] tau2;
  matrix[2, 2] T;
  for (i in 1:2) {
    tau2[i] <- pow(tau[i], 2);
  }
  {
    vector[2] P1_diag;
    P1_diag[1] <- P1_1;
    P1_diag[2] <- tau2[2] / (1 - pow(rho, 2));
    P1 <- diag_matrix(P1_diag);
  }
  T[1, 1] <- 1.0;
  T[1, 2] <- 0.0;
  T[2, 1] <- 0.0;
  T[2, 2] <- rho;
  for (i in 1:n) {
    H[i, 1] <- sigma2 + meas_err[i];
  }
  Q <- diag_matrix(tau2);
}
model {
  matrix[2, 2] RQR;
  RQR <- R * Q * R';
  { real KALMAN_SEQ_v; vector[rows(T)] KALMAN_SEQ_K; real KALMAN_SEQ_Finv; vector[rows(T)] KALMAN_SEQ_a; matrix[rows(T), rows(T)] KALMAN_SEQ_P; vector[rows(T)] KALMAN_SEQ_M; real KALMAN_SEQ_F; KALMAN_SEQ_a <- a1; KALMAN_SEQ_P <- P1; for (i in 1:cols(y)) { for (j in 1:rows(y)) { vector[rows(T)] KALMAN_SEQ_Zj; KALMAN_SEQ_Zj <- Z[j] '; KALMAN_SEQ_v <- y[j, i] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M '; KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P '); lp__ <- lp__ - 0.5 * (log(2 * pi()) + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); } KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T ' + RQR; KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P '); } };
  lp__ <- lp__ - log(sigma2);;
  tau ~ cauchy(0, sqrt(sigma2));
  rho ~ normal(rho_mean, rho_sd) T[rho_lb, rho_ub];
}
