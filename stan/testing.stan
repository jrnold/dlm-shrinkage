data {
  int r;
  int n;
  int T;
  matrix[r, T] y;
  matrix[n, r] F;
  vector<lower=0.0>[r] V;
  matrix[n, n] G;
  matrix[n, n] W;
  vector[n] m0;
  matrix[n, n] C0;
}
parameters {
  real foo;
}
transformed parameters {
  real lp;
  {
    vector[r] LL;
    vector[n] m;
    matrix[n, n] C;
    real f;
    real Q;
    real Q_inv;
    real e;
    vector[n] A;
    vector[n] Fj;
    m <- m0;
    C <- C0;
    for (i in 1:T) {
      m <- G * m;
      C <- G * C * G ' + W;
      C <- 0.5 * (C + C');
      for (j in 1:r) {
        Fj <- col(F, j);
        f <- dot_product(Fj, m);
        Q <- Fj ' * C * Fj + V[j]; 
        Q_inv <- 1.0 / Q;
        e <- y[j, i] - f;
        A <- C * Fj * Q_inv;
        m <- m + A * e;
        C <- C - Q * A * A '; 
        C <- 0.5 * (C + C');
        LL[j] <- (-0.5
                  * (log(Q)
                    + Q_inv * pow(e, 2)));
      }
      lp <- lp + sum(LL);
    }
  }
}
model {
  foo ~ normal(0, 1);
}
