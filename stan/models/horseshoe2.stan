// local trend model with indepdent HP on level and trend
data {
  // number of observations
  int n_obs;
  // number of states
  int n_time;
  // observed data
  real y[n_obs];
  // times of observed data
  int y_time[n_obs];
  // initial values
  real theta1_mean[2];
  real<lower=0.0> theta1_sd[2];
}
parameters {
  // latent states
  vector[n_time] theta_innov[2];
  // measurement error
  real logsigma;
  // system error
  vector<lower=0.0>[n_time - 1] lambda[2];
  real<lower=0.0> tau[2];
}
transformed parameters {
  real<lower=0.0> sigma;
  vector[n_time] theta[2];
  real yhat[n_obs];

  sigma <- exp(logsigma);

  for (i in 1:2) {
    theta[i, 1] <- theta1_mean[i] + theta1_sd[i] * theta_innov[i, 1];
  }
  for (t in 2:n_time) {
    theta[2, t] <- theta[2, t - 1] + lambda[2, t - 1] * tau[2] * theta_innov[2, t];
    theta[1, t] <- (theta[1, t - 1] 
                    + theta[2, t - 1]
                    + lambda[1, t - 1] * tau[1] * theta_innov[1, t]);
  }
  for (i in 1:n_obs) {
    yhat[i] <- theta[1, y_time[i]];
  }
}
model {
  for (i in 1:2) {
    theta_innov[i] ~ normal(0.0, 1.0);
    lambda[i] ~ cauchy(0.0, 1.0);
  }
  tau ~ cauchy(0.0, sigma);
  y ~ normal(yhat, sigma);
}
generated quantities {
  real llik[n_obs];
  real deviance;

  for (i in 1:n_obs) {
    llik[i] <- normal_log(y[i], yhat[i], sigma);
  }
  deviance <- -2 * sum(llik);
}
