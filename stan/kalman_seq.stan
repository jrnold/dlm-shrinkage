// Kalman Filter (Multivariate Form)
// - no missing values
data {
  // dimensions
  int m; // dimension of state vector
  int p; // number of variables
  int n; // number of observations
  int r; // number of disturbances
  // system matrices
  cov_matrix[m] P1;
  vector[m] a1;
  // data
  vector[p] y[n]; // rows = variables; cols = observations
}
transformed data {
  matrix[2, 2] L;
  matrix[2, 2] T;
  matrix[1, 2] Z;
  for (i in 1:2) {
    for (j in 1:2) {
      if (i > j) {
        L[i, j] <- 0;
      } else {
        L[i, j] <- 1;
      }
    }
  }
  Z[1, 1] <- 1;
  Z[1, 2] <- 0;
  
                  
}
parameters {
  real<lower=0.0> H;
}
transformed parameters {
  
}
transformed data {
  // log-lilelihood
  real loglik_obs[n, p];
  real loglik;


  // Kalman Filter block
  {
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
        vector[m] Zj;
        Zj <- Z[j]';
        v <- y[i, j] - c[j] - dot_product(Zj, a);
        M <- P * Zj;
        F <- dot_product(Zj, M) + H[j];
        Finv <- 1 / F;
        K <- M * Finv;
        a <- a + K * v;
        P <- P - K * M';
        P <- 0.5 * (P + P');  // keep symmetric
        loglik_obs[i, j] <- -0.5 * (log(2 * pi()) 
                                    + log(F) + Finv * pow(v, 2.0));

      }
      // // predict
      a <- d + T * a;
      P <- T * P * T' + RQR;
      P <- 0.5 * (P + P');
    }
  }
  loglik <- 0.0;
  for (i in 1:n) {
    loglik <- loglik + sum(loglik_obs[i]);
  }
}
parameters {
  // placeholder
  real foo;
}
model {
  foo ~ normal(0.0, 1.0);
}

