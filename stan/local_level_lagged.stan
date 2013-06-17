// Kalman Filter (Multivariate Form)
// - no missing values
data {
  // dimensions
  int n; // number of observations
  // system matrices
  cov_matrix[2] P1;
  vector[2] a1;
  // data
  vector[1] y[n]; //
  int missing[n, 1]; //
  vector<lower=0.0>[1] H[n]; // observation variances (given)
}
transformed data {
  matrix[2, 1] R;
  matrix[1, 2] T;
  vector[1] c;
  vector[2] d;
  int m;
  int r;
  int p;
  m <- 2;
  r <- 1;
  p <- 1;
  R[1, 1] <- 0;
  R[2, 1] <- 1;
  T[1, 1] <- 1;
  T[1, 0] <- 0;
  c[1] <- 0;
  d[1] <- 0;
  d[2] <- 0;
}
parameters {
  cov_matrix[1] Q;
  real<lower=-1, upper=1> rho;
}
transformed parameters {
  matrix[2, 2] Z;
  Z[1, 1] <- 1;
  Z[1, 2] <- 1;
  Z[2, 1] <- 0;
  Z[2, 2] <- rho;
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

    RQR <- R * Q * R';
    
    a <- a1;
    P <- P1;
    for (i in 1:n) {
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
}
