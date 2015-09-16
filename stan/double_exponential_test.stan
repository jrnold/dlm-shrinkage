/* sample from the double exponential (Laplace distribution)

Check that scale mixture normals with exponential mixing distribution is the same as
the double exponential distribution

*/
data {
  real<lower = 0.0> tau;
}
parameters {
  real y1;
  real y2;
  real<lower = 0.0> sigma2;
}
model {
  y1 ~ double_exponential(0.0, tau);
  y2 ~ normal(0.0, sqrt(sigma2));
  sigma2 ~ exponential(0.5 * pow(tau, -2));
}
