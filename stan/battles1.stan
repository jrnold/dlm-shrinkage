data {
  int T;
  int n;
  vector[T] y;
  matrix[T, n] X;
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
}
