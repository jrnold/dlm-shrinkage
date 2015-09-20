data {
  int<lower = 1> n;
  int<lower = 0> M; // number of variables
  vector[n] y;
  matrix[n, M] X;
  // initial value
  real m0;
  real<lower = 0.0> C0;
  real<lower = 0.0> w;
  real<lower = 0.0> s;
}
parameters {
  real<lower = 0.0> sigma;
  real mu0;
  vector[M] omega;
}
transformed parameters {
  vector[n] mu;
  mu <- mu0 + X * omega;
}
model {
  mu0 ~ normal(m0, C0);
  omega ~ cauchy(0, w);
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
    err[i] <- mu[i] - y[i];
  }
  for (i in 1:n) {
    yhat[i] <- normal_rng(mu[i], sigma);
    err_hat[i] <- yhat[i] - y[i];
  }
}
