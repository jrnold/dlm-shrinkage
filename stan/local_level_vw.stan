data {
  int T;
  matrix[1, T] y;
  matrix[1, 1] F;
  matrix[1, 1] G;
  vector[1] m0;
  cov_matrix[1] C0;
  vector[T] V_a;
  vector<lower=0.0>[T] V_b;
  vector[T] W_a;
  vector<lower=0.0>[T] W_b;
}
parameters {
  real<lower=0.0> sigma;
  real<lower=0.0> tau;
}
transformed parameters {
  vector[1] V[T];
  matrix[1, 1] W[T];
  for (i in 1:T) {
    V[i, 1] <- V_a[i] + V_b[i] * pow(sigma, 2);
    W[i, 1, 1] <- W_a[i] + W_b[i] * pow(tau * sigma, 2);
  }
}
model {
  { vector[1] KALMANF_LL; vector[1] KALMANF_m; matrix[1, 1] KALMANF_C; real KALMANF_f; real KALMANF_Q; real KALMANF_Q_inv; real KALMANF_e; vector[1] KALMANF_A; vector[1] KALMANF_Fj; KALMANF_m <- m0; KALMANF_C <- C0; for (KALMANF_i in 1:cols(y)) { KALMANF_m <- G * KALMANF_m; KALMANF_C <- G * KALMANF_C * G ' + W[KALMANF_i]; KALMANF_C <- 0.5 * (KALMANF_C + KALMANF_C '); for (KALMANF_j in 1:1) { KALMANF_Fj <- col(F, KALMANF_j); KALMANF_f <- dot_product(KALMANF_Fj, KALMANF_m); KALMANF_Q <- KALMANF_Fj ' * KALMANF_C * KALMANF_Fj + V[KALMANF_i][KALMANF_j]; KALMANF_Q_inv <- 1.0 / KALMANF_Q; KALMANF_e <- y[KALMANF_j, KALMANF_i] - KALMANF_f; KALMANF_A <- KALMANF_C * KALMANF_Fj * KALMANF_Q_inv; KALMANF_m <- KALMANF_m + KALMANF_A * KALMANF_e; KALMANF_C <- KALMANF_C - KALMANF_Q * KALMANF_A * KALMANF_A '; KALMANF_C <- 0.5 * (KALMANF_C + KALMANF_C '); KALMANF_LL[KALMANF_j] <- (-0.5 * (log(KALMANF_Q) + KALMANF_Q_inv * pow(KALMANF_e, 2))); } lp__ <- lp__ + sum(KALMANF_LL); } };
  lp__ <- lp__ - log(sigma);;
  tau ~ cauchy(0, 1);
}
