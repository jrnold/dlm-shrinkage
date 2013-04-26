// local level model with arbitrary system interventions
data {
  // number of observations
  int n_obs;
  // number of states
  int n_time;
  // observed data
  real y[n_obs];
  // times of observed data
  int y_time[n_obs];
  // initial values/ interventions
  real theta1_mean[n_time];
  real<lower=0.0> theta1_sd[n_time];
}
parameters {
  // latent states
  real theta_innov[n_time];
  real logsigma;
  real<lower=0.0> tau;
}
transformed parameters {
  real<lower=0.0> sigma;
  real theta[n_time];
  real yhat[n_obs];
  sigma <- exp(logsigma);

  theta[1] <- theta1_mean[1] + theta1_sd[1] * theta_innov[1];
  for (i in 2:n_time) {
    theta[i] <- (theta[i - 1] 
                 + theta1_mean[i]
                 + sqrt(pow(tau, 2) + pow(theta1_sd[i - 1], 2)) 
                 * theta_innov[i]);
  }
  for (i in 1:n_obs) {
    yhat[i] <- theta[y_time[i]];
  }
}
model {
  theta_innov ~ normal(0.0, 1.0);
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
