data {
  // number of observations
  int n_obs;
  // number of states
  int n_time;
  // observed data
  real y[n_obs];
  // times of observed data
  int<lower=1, upper=n_time> y_time[n_obs];
  // initial values
  real theta1_mean1;
  real<lower=0.0> theta1_sd1;
  real theta1_mean2;
  real<lower=0.0> theta1_sd2;
}
parameters {
  // levels
  real theta_innov1[n_time];
  real<lower=0.0> lambda1[n_time - 1];
  real<lower=0.0> tau1;

  // slopes
  real theta_innov2[n_time];
  real<lower=0.0> lambda2[n_time - 1];
  real<lower=0.0> tau2;

  // measurement error
  real logsigma;
}
transformed parameters {
  real<lower=0.0> sigma;
  real theta1[n_time];
  real theta2[n_time];
  real yhat[n_obs];

  sigma <- exp(logsigma);

  // slopes
  theta2[1] <- theta1_mean2 + theta1_sd2 * theta_innov2[1];
  for (i in 2:n_time) {
    theta2[i] <- theta2[i - 1] + sigma * lambda2[i-1] * tau2 * theta_innov2[i];
  }
  // levels
  theta1[1] <- theta1_mean1 + theta1_sd1 * theta_innov1[1];
  for (i in 2:n_time) {
    theta1[i] <- theta1[i - 1] + theta2[i - 1] +  sigma * lambda1[i-1] * tau1 * theta_innov1[i];
  }

  for (i in 1:n_obs) {
    yhat[i] <- theta1[y_time[i]];
  }
}
model {
  theta_innov1 ~ normal(0.0, 1.0);
  lambda1 ~ cauchy(0.0, 1.0);
  tau1 ~ cauchy(0, sigma);

  theta_innov2 ~ normal(0.0, 1.0);
  lambda2 ~ cauchy(0.0, 1.0);
  tau2 ~ cauchy(0, sigma);

  // half-cauchy since lambda > 0.
  y ~ normal(yhat, sigma);

}