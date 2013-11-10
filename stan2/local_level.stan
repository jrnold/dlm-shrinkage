data {
  int T;
  matrix[1, T] y;
  matrix[1, 1] F;
  matrix[1, 1] G;
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
  real<lower=0.0> tau;
}
transformed parameters {
  vector<lower=0.0>[1] V;
  matrix[1, 1] W;
  // Kalman filter to save
  vector[n] a[T];     
  matrix[n, n] R[T];
  vector[n] m[T];     
  matrix[n, n] C[T];
  vector[T] llik;

  V[1] <- pow(sigma, 2);
  W[1, 1] <- pow(tau * sigma, 2);

  {
    real LL; 
    vector[n] m;     
    matrix[n, n] C;  
    vector[r] f;  
    matrix[r, r] Q;  
    matrix[r, r] Q_inv;  
    vector[r] err;  
    matrix[n, r] A;  
    m <- m0;  
    C <- C0;
    for (i in 1:cols(y)) { 
      a <- G * m;  
      R <- G * C * G _T + W; 
      R <- R 
      f <- F _T * a; 
      Q <- F _T * R * F + V; 
      Q <- _MAKE_SYMMETRIC(Q); 
      Q_inv <- inverse(Q); 
      err <- col(y, i) - f; 
      A <- R * F * Q_inv; 
      m <- a + A * err; 
      C <- R - A * Q * A _T; 
      C <- _MAKE_SYMMETRIC(C); 
      LL <- (-0.5 
             * (log_determinant(Q) 
                + err _T * Q_inv * err)); 
      llik[i] <- LL; 
    }  
  }
}
model {
  
  tau ~ cauchy(0, 1);
}
