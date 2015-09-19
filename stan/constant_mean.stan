// model with NO changepoints
data {
  int<lower = 1> n;
  vector[n] y;
  // initial value
  real m0;
  real<lower = 0.0> C0;
  // scale of innovations
  real<lower = 0.0> s;
}
parameters {
  real<lower = 0.0> sigma;
  real mu;
}
model {
  mu ~ normal(m0, C0);
  sigma ~ cauchy(0, s);
  y ~ normal(mu, sigma);
}
generated quantities {
  vector[n] yhat;
  vector[n] err;
  vector[n] err_hat;
  vector[n] log_lik;
  for (i in 1:n) {
    log_lik[i] <- normal_log(y[i], mu, sigma);
    err[i] <- mu - y[i];
  }
  for (i in 1:n) {
    yhat[i] <- normal_rng(mu, sigma);
    err_hat[i] <- yhat[i] - y[i];
  }
}
