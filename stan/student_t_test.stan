/* sample from the Student's t distribution

Check that scale mixture normals is the same as
the double exponential distribution

*/
data {
  real<lower = 0.0> tau;
  real<lower = 0.0> nu;
}
parameters {
  real y1;
  real y2;
  real y3;
  real<lower = 0.0> sigma2;
}
model {
  y1 ~ student_t(nu, 0.0, tau);
  y2 ~ normal(0.0, sqrt(sigma2));
  sigma2 ~ inv_gamma(0.5 * nu, 0.5 * pow(tau, 2) * nu);
  y3 ~ normal(0.0, tau);
}
