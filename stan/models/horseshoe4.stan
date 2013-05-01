data {
  // number of observations
  int n_obs;
  // observed data
  real y[n_obs];
  // initial values
  real theta_mean[2];
  real<lower=0.0> theta_sd[2];
  real<lower=0.0> nu;
}
parameters {
  // latent states
  real theta0_innov[n_obs];
  real theta1_innov[n_obs];
  // measurement error
  real logsigma;
  // system error
  real<lower=0.0> lambda[n_obs -1];
  real<lower=0.0> tau[2];
}
transformed parameters {
  real<lower=0.0> sigma;
  real theta0[n_obs];
  real theta1[n_obs];

  sigma <- exp(logsigma);

  theta0[1] <- theta_mean[1] + theta_sd[1] * theta0_innov[1];
  theta1[1] <- theta_mean[2] + theta_sd[2] * theta1_innov[1];
  for (i in 2:n_obs) {
    theta1[i] <- theta1[i - 1] + tau[2] * lambda[i - 1] * tau[1] * sigma * theta1_innov[i];
    theta0[i] <- theta0[i - 1] + theta1[i - 1] + lambda[i - 1] * tau[1] * sigma * theta0_innov[i];
  }
}
model {
  theta0_innov ~ normal(0.0, 1.0);
  theta1_innov ~ normal(0.0, 1.0);
  // half-cauchy since lambda > 0.
  lambda ~ cauchy(0.0, 1.0);
  tau ~ cauchy(0.0, 1.0);
  y ~ student_t(nu, theta0, sigma);
}
generated quantities {
  real llik[n_obs];
  real deviance;
  real kappa[n_obs];

  for (i in 1:n_obs) {
    llik[i] <- student_t_log(y[i], nu, theta0[i], sigma);
  }
  deviance <- -2 * sum(llik);
  {
    real sigma2;
    sigma2 <- pow(sigma, 2.0);
    kappa[1] <- sigma2 / (sigma2 + pow(theta_sd[1], 2));
    for (i in 2:n_obs) {
      kappa[i] <- 1 / (1 + pow(lambda[i - 1], 2) * pow(tau[1], 2));
    }
  }
}
