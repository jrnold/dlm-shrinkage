data {
  // number of observations
  int n_obs;
  // observed data
  real y[n_obs];
  // initial values
  real theta1_mean;
  real<lower=0.0> theta1_sd;
}
parameters {
  // latent states
  real theta_innov[n_obs];
  real logsigma;
  real<lower=0.0> tau;
}
transformed parameters {
  real<lower=0.0> sigma;
  real theta[n_obs];
  sigma <- exp(logsigma);

  theta[1] <- theta1_mean + theta1_sd * theta_innov[1];
  for (i in 2:n_obs) {
    theta[i] <- theta[i-1] + sigma * tau * theta_innov[i];
  }
}
model {
  theta_innov ~ normal(0.0, 1.0);
  tau ~ cauchy(0.0, 1.0);
  y ~ normal(theta, sigma);
}
generated quantities {
  real llik[n_obs];
  real deviance;
  
  for (i in 1:n_obs) {
    llik[i] <- normal_log(y[i], theta[i], sigma);
  }
  deviance <- -2 * sum(llik);
}
