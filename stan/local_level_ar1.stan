data {
  int T;
  matrix[1, T] y;
  matrix[1, 1] F;
  matrix[1, 1] G0;
  vector[1] m0;
  cov_matrix[1] C0;
}
transformed data {
  int r;
  int n;
  r <- 1;
  n <- 1;
}
parameters {
  real<lower=0.0> sigma;
  vector<lower=0.0>[2] tau;
  real<lower=-1.0, upper=1.0> rho;
}
transformed parameters {
  vector<lower=0.0>[1] V;
  vector<lower=0.0>[2] W_diag;
  matrix[2, 2] W;
  matrix[2, 2] G;
  V[1] <- pow(sigma, 2);
  for (i in 1:2) {
    W_diag[i] <- pow(tau[i] * sigma, 2);
  }
  W <- diag_matrix(W_diag);
  G <- G0;
  G[2, 2] <- rho;
}
model {
  { vector[r] KALMANF_LL; vector[n] KALMANF_m; matrix[n, n] KALMANF_C; real KALMANF_f; real KALMANF_Q; real KALMANF_Q_inv; real KALMANF_e; vector[n] KALMANF_A; vector[n] KALMANF_Fj; KALMANF_m <- m0; KALMANF_C <- C0; for (i in 1:T) { KALMANF_m <- G * KALMANF_m; KALMANF_C <- G ' * KALMANF_C * G + W; KALMANF_C <- 0.5 * (KALMANF_C + KALMANF_C '); for (j in 1:r) { KALMANF_Fj <- col(F, j); KALMANF_f <- dot_product(KALMANF_Fj, KALMANF_m); KALMANF_Q <- KALMANF_Fj ' * KALMANF_C * KALMANF_Fj + V[j]; KALMANF_Q_inv <- 1.0 / KALMANF_Q; KALMANF_e <- y[j, i] - KALMANF_f; KALMANF_A <- KALMANF_C * KALMANF_Fj * KALMANF_Q_inv; KALMANF_m <- KALMANF_m + KALMANF_A * KALMANF_e; KALMANF_C <- KALMANF_C - KALMANF_Q * KALMANF_A * KALMANF_A '; KALMANF_C <- 0.5 * (KALMANF_C + KALMANF_C '); KALMANF_LL[j] <- (-0.5 * (log(2 * pi()) + log(KALMANF_Q) + KALMANF_Q_inv * pow(KALMANF_e, 2.0))); } lp__ <- lp__ + sum(KALMANF_LL); } };
  lp__ <- lp__ - log(sigma);;
  tau ~ cauchy(0, 1);
}
