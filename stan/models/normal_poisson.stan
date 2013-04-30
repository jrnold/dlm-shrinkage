data {
  // number of observations
  int n_obs;
  // number of states
  int n_time;
  // observed data
  int y[n_obs];
  // times of observed data
  int y_time[n_obs];
  // initial values
  real theta1_mean;
  real<lower=0.0> theta1_sd;
  real<lower=0.0> sigma;
}
parameters {
  // latent states
  real theta_innov[n_time];
  real<lower=0.0> tau;
}
transformed parameters {
  real theta[n_time];
  real yhat[n_obs];

  theta[1] <- theta1_mean + theta1_sd * theta_innov[1];
  for (i in 2:n_time) {
    theta[i] <- theta[i-1] + tau * theta_innov[i];
  }
  for (i in 1:n_obs) {
    yhat[i] <- exp(theta[y_time[i]]);
  }
}
model {
  theta_innov ~ normal(0.0, 1.0);
  tau ~ cauchy(0.0, sigma);
  y ~ poisson(yhat);
}
generated quantities {
  real llik[n_obs];
  real deviance;

  for (i in 1:n_obs) {
    llik[i] <- poisson_log(y[i], yhat[i]);
  }
  deviance <- -2 * sum(llik);
}
