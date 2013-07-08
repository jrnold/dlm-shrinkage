model {
  int n;
  cov_matrix[1] P1;
  vector[1] a1;
  matrix[1, n] y;
  matrix[] T;
  matrix[] Z;
  matrix[] R;
}
transformed data {
  int m;
  int r;
  int p;
  matrix[1, 1] Z;
  matrix[1, 1] T;
  matrix[1, 1] R;
  vector[1] c;
  vector[1] d;
}
