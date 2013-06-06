// Kalman Filter (Multivariate Form)
// - no missing values
data {
  // dimensions
  int n; // number of observations
  real a1;
  real<lower=0.0> P1;
  // data
  real y[n]; // rows = variables; cols = observations
  int missing[n]; // rows = variables; cols = observations
}
parameters {
  // system matrices
  real<lower=0.0> H;
  real<lower=0.0> tau;
  vector<lower=0.0>[n] lambda;
}
transformed parameters {
  vector<lower=0.0>[n] Q;
  for (i in 1:n) {
    Q[i] <- pow(lambda[i], 2.0) * pow(tau, 2.0) * H;
  }
}
model {
  // log-lilelihood
  real loglik_obs[n];

  // Kalman Filter block
  {
    // filter output
    real v;
    real K;
    real Finv;
    
    // state predictions a_{t}, P_{t}
    real a;
    real P;
    // temp variables
    // real M;
    real F;
    
    a <- a1;
    P <- P1;
    for (i in 1:n) {
      if (! missing[i]) {
        // filter
        v <- y[i] - a;
        // M <- P;
        F <- P + H;
        Finv <- 1 / F;
        K <- P * Finv;
        a <- a + K * v;
        P <- (1 - K ) * P;
        loglik_obs[i] <- -0.5 * (log(2 * pi()) 
                                 + log(F) + Finv * pow(v, 2.0));
      } else {
        loglik_obs[i] <- 0.0;
      }
      // // predict
      // a <- a;
      P <- P + Q[i];
    }
  }
  lp__ <- sum(loglik_obs);

  // prior on obs var
  lp__ <- lp__ + 1.0 / H;
  // Horseshoe prior
  lambda ~ cauchy(0, 1);
  tau ~ cauchy(0, 1);
}

