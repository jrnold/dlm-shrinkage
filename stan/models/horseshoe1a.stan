data {
  // number of observations
  int n_obs;
  int n_time;
  // observed data
  real y[n_obs];
  int y_time[n_obs];
  // initial values
  real theta1_mean;
  real<lower=0.0> theta1_sd;
}
parameters {
  // latent states
  real theta_innov[n_time];
  // measurement error
  real logsigma;
  // system error
  real<lower=0.0> lambda[n_time -1];
  real<lower=0.0> tau;
}
transformed parameters {
  real<lower=0.0> sigma;
  real theta[n_time];
  real yhat[n_obs];

  sigma <- exp(logsigma);

  theta[1] <- theta1_mean + theta1_sd * theta_innov[1];
  for (i in 2:n_time) {
    theta[i] <- theta[i-1] + lambda[i-1] * tau * sigma * theta_innov[i];
  }
  for (i in 1:n_obs) {
    yhat[i] <- theta[y_time[i]];
  }
}
model {
  theta_innov ~ normal(0.0, 1.0);
  // half-cauchy since lambda > 0.
  lambda ~ cauchy(0.0, 1.0);
  tau ~ cauchy(0.0, 1.0);
  y ~ normal(yhat, sigma);
}
generated quantities {
  real llik[n_obs];
  real deviance;
  real kappa[n_time];

  for (i in 1:n_obs) {
    llik[i] <- normal_log(y[i], yhat[i], sigma);
  }
  deviance <- -2 * sum(llik);
  {
    real sigma2;
    sigma2 <- pow(sigma, 2.0);
    kappa[1] <- sigma2 / (sigma2 + pow(theta1_sd, 2));
    for (i in 2:n_time) {
      kappa[i] <- 1 / (1 + pow(lambda[i - 1], 2) * pow(tau, 2));
    }
  }
}