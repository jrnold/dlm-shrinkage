data {
  int T;
  int n;
  vector[T] y;
  matrix[T, n] X;
  vector[n] b_mean;
  vector<lower=0.0>[n] b_sd;
}
parameters {
  vector[n] b;
  real<lower=0.0> sigma;
}
transformed parameters {
  vector[T] mu;
  mu <- X * b;
}
model {
  y ~ normal(mu, sigma);
  lp__ <- lp__ - log(sigma);;
  b ~ normal(b_mean, b_sd);
}
