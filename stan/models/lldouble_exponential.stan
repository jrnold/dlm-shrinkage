data {
  // number of observations
  int n;
  // observed data
  real y[n];
  // initial values
  real theta1_mean;
  real<lower=0.0> theta1_sd;
}
parameters {
  // latent states
  real theta[n];
  // measurement error
  real logsigma;
  // system error
  real<lower=0.0> lambda[n-1];
  real<lower=0.0> tau;
}
transformed parameters {
  real<lower=0.0> sigma;
  sigma <- exp(logsigma);
}
model {
  theta[1] ~ normal(theta1_mean, theta1_sd);
  for (i in 2:n) {
    theta[i] ~ double_exponential(theta[i-1], lambda);
  }
  y ~ normal(theta, sigma);
}
