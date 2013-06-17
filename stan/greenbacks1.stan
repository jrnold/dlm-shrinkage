// Kalman Filter (Multivariate Form)
// - no missing values
data {
  // dimensions
  int n; // number of observations
  // system matrices
  cov_matrix[1] P1;
  vector[1] a1;
  // data
  vector[1] y[n]; //
  int missing[n, 1]; //
  real<lower=0.0> meas_err[n]; // observation variances (given)
}
transformed data {
  int m;
  int r;
  int p;
  matrix[1, 1] Z;
  matrix[1, 1] T;
  matrix[1, 1] R;
  vector[1] c;
  vector[1] d;
  m <- 1;
  r <- 1;
  p <- 1;
  T[1, 1] <- 1;
  Z[1, 1] <- 1;
  R[1, 1] <- 1;
  c[1] <- 0;
  d[1] <- 0;
}
parameters {
  real<lower=0.0> sigma2;
  real<lower=0.0> tau;
  //  vector<lower=0.0>[n] lambda;
}
transformed parameters {
  vector<lower=0.0>[1] H[n];
  matrix<lower=0.0>[1, 1] Q[n];
  for (i in 1:n) {
    H[i, 1] <- sigma2 + meas_err[i];
  }
  for (i in 1:n) {
    Q[i, 1, 1] <- pow(tau, 2) * sigma2;
  }
}
model {
  // Kalman Filter block
  { // T, Z, H, Q, R, a1, P1
    matrix[m, m] RQR;
    // filter output
    real v;
    vector[m] K;
    real Finv;

    // state predictions a_{t}, P_{t}
    vector[m] a;
    matrix[m, m] P;
    // temp variables
    vector[m] M;
    real F;

    
    a <- a1;
    P <- P1;
    for (i in 1:n) {
      RQR <- R * Q[i] * R';
      for (j in 1:p) {
        if (! int_step(missing[i, j])) {
          vector[m] Zj;
          Zj <- Z[j]';
          v <- y[i, j] - c[j] - dot_product(Zj, a);
          M <- P * Zj;
          F <- dot_product(Zj, M) + H[i, j];
          Finv <- 1 / F;
          K <- M * Finv;
          a <- a + K * v;
          P <- P - K * M';
          P <- 0.5 * (P + P');  // keep symmetric
          lp__ <- lp__ - 0.5 * (log(2 * pi()) 
                                + log(F) + Finv * pow(v, 2.0));
        } 
      }
      // // predict
      a <- d + T * a;
      P <- T * P * T' + RQR;
      P <- 0.5 * (P + P');
    }
  } // end Kalman filter block
  lp__ <- lp__ - log(sigma2);
  tau ~ cauchy(0, 1);
  // lambda ~ cauchy(0, 1);
}
