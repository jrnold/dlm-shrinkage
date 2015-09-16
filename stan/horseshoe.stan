functions {
  {{> dlm}}
}
data {
  int<lower = 1> n;
  vector[n] y;
  real m0;
  real<lower = 0.0> C0;
  real<lower = 0.0> s;
}
transformed data {
  real one_over_n;
  one_over_n <- 1.0 / n;
}
parameters {
  real<lower = 0.0> sigma;
  real<lower = 0.0> tau;
  vector<lower = 0.0>[n] lambda;
}
transformed parameters {
  vector[1] log_lik[n];
  vector[n] W;
  vector[6] dlm;
  for (i in 1:n) {
    W[i] <- pow(sigma, 2) * pow(lambda, 2);
  }
  {
    vector[n] V;
    V <- rep_vector(pow(sigma, 2), n);
    dlm <- dlm_local_level_filter(n, V, W, m0, c0);
  }
  loglik <- dlm_loglik_filter(n, 1, 1, dlm);
}
model {
  sigma ~ cauchy(0, s);
  lambda ~ cauchy(0, tau);
  tau ~ cauchy(0, one_over_n);
  for (i in 1:n) {
    increment_log_prob(log_lik[i, 1]);
  }
}
generated quantities {
  // theta
  // epsilon
  // kalman gain
}
