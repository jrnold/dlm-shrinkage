data {
  int n;
  real y[n];
  real a1;
  real<lower=0.0> P1;
}
parameters {
  real<lower=0.0> H;
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
  {
    real loglik_obs[n];
    real a;
    real P;
    real v;
    real K;
    real F;
    real Finv;
    a <- a1;
    P <- P1;
    for (i in 1:n) {
      v <- y[i] - a;
      F <- P + H;
      Finv <- 1 / F;
      K <- P * Finv;
      a <- a + K * v;
      P <- (1 - K ) * P;
      loglik_obs[i] <- -0.5 * (log(2 * pi())
                               + log(F) + Finv * pow(v, 2.0));
      P <- P + Q[i];
    }
    lp__ <- sum(loglik_obs);
  }
  lp__ <- lp__ - log(H);
  tau ~ cauchy(0, sqrt(H));
  lambda ~ cauchy(0, 1);
}
