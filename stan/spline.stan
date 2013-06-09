// Kalman Filter (Multivariate Form)
// - no missing values
data {
  // data
  int n;
  real y[n];
  real ydiff[n];
  // system matrices
  cov_matrix[2] P1;
  vector[2] a1;
}
transformed data {
  matrix[2, 2] Q0[n];
  matrix[2, 2] T[n];
  row_vector[2] Z;
  real<lower=0.0> H;
  for (i in 1:n) {
    // Fill in H
    Q0[i, 1, 1] <- (1.0 / 3.0) * pow(ydiff[i], 3);
    Q0[i, 1, 2] <- 0.5 * pow(ydiff[i], 2);
    Q0[i, 2, 1] <- Q0[i][1, 2];
    Q0[i, 2, 2] <- ydiff[i];
    // fill in T;
    T[i, 1, 1] <- 1;
    T[i, 1, 2] <- ydiff[i];
    T[i, 2, 1] <- 0;
    T[i, 2, 2] <- 1;
  }
  // Z = [1, 0]
  Z[1] <- 1;
  Z[2] <- 0;
  H <- 1;
}
parameters {
  // signal to noise ratio
  real<lower=0.0> q;
}
transformed parameters {
  cov_matrix[2] Q[n];
  for (i in 1:n) {
    Q[i] <- Q0[i] * q;
  }
}
model {
  // log-lilelihood
  vector[n] loglik_obs;

  // Kalman Filter block
  {
    // filter output
    real v;
    vector[2] K;
    real Finv;

    // state predictions a_{t}, P_{t}
    vector[2] a;
    matrix[2, 2] P;
    // temp variables
    vector[2] M;
    real F;
    
    a <- a1;
    P <- P1;
    for (i in 1:n) {
      // filtering
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
      // // predict
      a <- T[i] * a;
      P <- T[i] * P * T[i]' + Q[i];
      P <- 0.5 * (P + P');
    }
  }
  lp__ <- lp__ + sum(loglik_obs);
}
