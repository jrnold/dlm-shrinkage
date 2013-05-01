// local trend model with indepdent HP on level and trend
data {
  // number of observations
  int n_obs;
  // times of observed data
  real y[n_obs];
  // initial values
  real theta1_mean;
  real<lower=0.0> theta1_sd;
  real x[n_obs];
}
parameters {
  // latent states
  vector[n_obs] theta_innov;
  // measurement error
  real logsigma;
  // system error
  real<lower=0.0> tau;
  // intervention parameter
  real beta;
}
transformed parameters {
  real<lower=0.0> sigma;
  vector[n_obs] theta;
  real yhat[n_obs];

  sigma <- exp(logsigma);

  theta[1] <- theta1_mean + theta1_sd * theta_innov[1];
  for (t in 2:n_obs) {
    theta[t] <- theta[t - 1] + tau * theta_innov[t];
  }
  for (t in 1:n_obs) {
    yhat[t] <- theta[t] + beta * x[t];
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
