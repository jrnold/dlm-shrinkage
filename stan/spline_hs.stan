data {
  int n;
  real y[n];
  real ydiff[n];
  cov_matrix[2] P1;
  vector[2] a1;
}
transformed data {
  matrix[2, 2] Q0[n];
  matrix[2, 2] T[n];
  row_vector[2] Z;
  real<lower=0.0> H;
  for (i in 1:n) {
    Q0[i, 1, 1] <- (1.0 / 3.0) * pow(ydiff[i], 3);
    Q0[i, 1, 2] <- 0.5 * pow(ydiff[i], 2);
    Q0[i, 2, 1] <- Q0[i][1, 2];
    Q0[i, 2, 2] <- ydiff[i];
    T[i, 1, 1] <- 1;
    T[i, 1, 2] <- ydiff[i];
    T[i, 2, 1] <- 0;
    T[i, 2, 2] <- 1;
  }
  Z[1] <- 1;
  Z[2] <- 0;
  H <- 1;
}
parameters {
  real<lower=0.0> tau;
  vector<lower=0.0>[n] lambda;
}
transformed parameters {
  cov_matrix[2] Q[n];
  for (i in 1:n) {
    Q[i] <- Q0[i] * pow(tau, 2) * lambda[i];
  }
}
model {
  vector[n] loglik_obs;
  {
    real v;
    vector[2] K;
    real Finv;
    vector[2] a;
    matrix[2, 2] P;
    vector[2] M;
    real F;
    a <- a1;
    P <- P1;
    for (i in 1:n) {
      v <- y[i] - dot_product(Z, a);
      M <- P * Z';
      F <- dot_product(Z, M) + H;
      Finv <- 1 / F;
      K <- M * Finv;
      a <- a + K * v;
      P <- P - K * M';
      P <- 0.5 * (P + P');  // keep symmetric
      loglik_obs[i] <- (-0.5 *
                        (log(2 * pi())
                         + log(F)
                         + Finv * pow(v, 2.0)));
      a <- T[i] * a;
      P <- T[i] * P * T[i]' + Q[i];
      P <- 0.5 * (P + P');
    }
  }
  lp__ <- lp__ + sum(loglik_obs);
  lambda ~ cauchy(0, 1);
  tau ~ cauchy(0, 1);
}
