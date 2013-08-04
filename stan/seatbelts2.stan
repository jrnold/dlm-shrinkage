data {
  int T;
  int n;
  matrix[1, T] y;
  matrix[n, 1] F;
  matrix[n, n] G;
  vector[n] m0;
  cov_matrix[n] C0;
}
parameters {
  real<lower=0.0> sigma;
  real<lower=0.0> tau;
  vector<lower=0.0>[T] lambda;
}
transformed parameters {
  vector<lower=0.0>[1] V;
  matrix[n, n] W[T];
  for (i in 1:T) {
    vector[n] W_diag;
    W_diag[1] <- pow(sigma * tau * lambda[i], 2);
    for (j in 2:n) {
      W_diag[j] <- 0.0;
    }
    W[i] <- diag_matrix(W_diag);
  }
  V[1] <- pow(sigma, 2);
}
model {
  { vector[1] KALMANF_LL; vector[n] KALMANF_m; matrix[n, n] KALMANF_C; real KALMANF_f; real KALMANF_Q; real KALMANF_Q_inv; real KALMANF_e; vector[n] KALMANF_A; vector[n] KALMANF_Fj; KALMANF_m <- m0; KALMANF_C <- C0; for (i in 1:T) { KALMANF_m <- G * KALMANF_m; KALMANF_C <- G ' * KALMANF_C * G + W[i]; KALMANF_C <- 0.5 * (KALMANF_C + KALMANF_C '); for (j in 1:1) { KALMANF_Fj <- col(F, j); KALMANF_f <- dot_product(KALMANF_Fj, KALMANF_m); KALMANF_Q <- KALMANF_Fj ' * KALMANF_C * KALMANF_Fj + V[j]; KALMANF_Q_inv <- 1.0 / KALMANF_Q; KALMANF_e <- y[j, i] - KALMANF_f; KALMANF_A <- KALMANF_C * KALMANF_Fj * KALMANF_Q_inv; KALMANF_m <- KALMANF_m + KALMANF_A * KALMANF_e; KALMANF_C <- KALMANF_C - KALMANF_Q * KALMANF_A * KALMANF_A '; KALMANF_C <- 0.5 * (KALMANF_C + KALMANF_C '); KALMANF_LL[j] <- (-0.5 * (log(2 * pi()) + log(KALMANF_Q) + KALMANF_Q_inv * pow(KALMANF_e, 2.0))); } lp__ <- lp__ + sum(KALMANF_LL); } };
  lp__ <- lp__ - log(sigma);;
  tau ~ cauchy(0, 1);
  lambda ~ cauchy(0, 1);
}
