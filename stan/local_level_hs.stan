      KALMANF_C <- 0.5 * (KALMANF_C + KALMANF_C '); KALMANF_LL[j] <- (-0.5 * (log(KALMANF_Q) + KALMANF_Q_inv * pow(KALMANF_e, 2))); >>>>>>> 81d48e8c6f60753562fa30708591d3823344cc64
    } lp__ <- lp__ + sum(KALMANF_LL); } }
data {
  int T;
  matrix[1, T] y;
  matrix[1, 1] F;
  matrix[1, 1] G;
  vector[1] m0;
  cov_matrix[1] C0;
}
parameters {
  real<lower=0.0> sigma;
  real<lower=0.0> tau;
  vector<lower=0.0>[T] lambda;
}
transformed parameters {
  vector[1] V;
  matrix[1, 1] W[T];
  V[1] <- pow(sigma, 2);
  for (i in 1:T) {
    W[i, 1, 1] <- pow(sigma * tau * lambda[i], 2);
  }
}
model {
  { vector[1] KALMANF_LL; vector[1] KALMANF_m; matrix[1, 1] KALMANF_C; real KALMANF_f; real KALMANF_Q; real KALMANF_Q_inv; real KALMANF_e; vector[1] KALMANF_A; vector[1] KALMANF_Fj; KALMANF_m <- m0; KALMANF_C <- C0; for (i in 1:T) { KALMANF_m <- G * KALMANF_m; KALMANF_C <- G ' * KALMANF_C * G + W[i]; KALMANF_C <- 0.5 * (KALMANF_C + KALMANF_C '); for (j in 1:1) { KALMANF_Fj <- col(F, j); KALMANF_f <- dot_product(KALMANF_Fj, KALMANF_m); KALMANF_Q <- KALMANF_Fj ' * KALMANF_C * KALMANF_Fj + V[j]; KALMANF_Q_inv <- 1.0 / KALMANF_Q; KALMANF_e <- y[j, i] - KALMANF_f; KALMANF_A <- KALMANF_C * KALMANF_Fj * KALMANF_Q_inv; KALMANF_m <- KALMANF_m + KALMANF_A * KALMANF_e; KALMANF_C <- KALMANF_C - KALMANF_Q * KALMANF_A * KALMANF_A '; KALMANF_C <- 0.5 * (KALMANF_C + KALMANF_C '); KALMANF_LL[j] <- (-0.5 * (log(2 * pi()) + log(KALMANF_Q_inv) + KALMANF_Q_inv * pow(KALMANF_e, 2.0))); } lp__ <- lp__ + sum(KALMANF_LL); } };
  lp__ <- lp__ - log(sigma);;
  lambda ~ cauchy(0, 1);
  tau ~ cauchy(0, 1);
}
