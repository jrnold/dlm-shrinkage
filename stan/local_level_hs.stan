// Local Level Model with Horseshoe Prior state disturbances
// Copyright: (2013) Jeffrey Arnold <jeffrey.arnold@gmail.com>
// License: BSD-2
data {
  // data
  int n; // number of observations
  real y[n]; // data
  // prior on first state
  real a1;
  real<lower=0.0> P1;
}
parameters {
  real<lower=0.0> H; // observation variance
  // parameters for state variance 
  real<lower=0.0> tau; 
  vector<lower=0.0>[n] lambda;
}
transformed parameters {
  vector<lower=0.0>[n] Q;
  for (i in 1:n) {
    Q[i] <- pow(lambda[i], 2.0) * pow(tau, 2.0);
  }
}
model {
  // Kalman Filter block
  {
    // loglikelihood for each observation
    real loglik_obs[n];
    // variables used 
    real a; // state expectation
    real P; // state variance
    real v; // forecast error
    real K; // Kalman gain
    real F; // forecast error
    real Finv; // forecast precision
    
    a <- a1;
    P <- P1;
    for (i in 1:n) {
      // filter step
      v <- y[i] - a;
      F <- P + H;
      Finv <- 1 / F;
      K <- P * Finv;
      a <- a + K * v;
      P <- (1 - K ) * P;
      loglik_obs[i] <- -0.5 * (log(2 * pi()) 
                               + log(F) + Finv * pow(v, 2.0));
      // prediction
      P <- P + Q[i];
    }
    lp__ <- sum(loglik_obs);
  }

  // Jeffrey's Prior on observation variance.
  lp__ <- lp__ + 1.0 / H;
  // Cauchy prior on global scale of state disturbances
  tau ~ cauchy(0, sqrt(H));
  // Cauchy priors on mixing parameters of state disturbances
  lambda ~ cauchy(0, 1);
}

