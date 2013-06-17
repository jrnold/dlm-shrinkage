#define KALMAN_SEQ_1111111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1111110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1111101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1111100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1111011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1111010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1111001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1111000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1110111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1110110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1110101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1110100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1110011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1110010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1110001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1110000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1101111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1101110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1101101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1101100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1101011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1101010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1101001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1101000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1100111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1100110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1100101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1100100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1100011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1100010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1100001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1100000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1011111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1011110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1011101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1011100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1011011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1011010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1011001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1011000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1010111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1010110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1010101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1010100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1010011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1010010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1010001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1010000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1001111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1001110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1001101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1001100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1001011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1001010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1001001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1001000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1000111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1000110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1000101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1000100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1000011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1000010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1000001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_1000000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T[i] * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T[i] * KALMAN_SEQ_P * T[i]' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0111111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0111110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0111101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0111100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0111011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0111010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0111001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0111000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0110111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0110110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0110101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0110100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0110011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0110010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0110001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0110000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0101111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0101110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0101101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0101100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0101011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0101010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0101001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0101000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0100111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0100110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0100101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0100100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0100011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0100010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0100001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0100000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0011111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0011110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0011101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0011100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0011011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0011010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0011001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0011000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0010111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0010110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0010101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0010100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0010011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0010010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0010001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0010000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[i, j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0001111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0001110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0001101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0001100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0001011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0001010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0001001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0001000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR[i]; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0000111(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0000110(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0000101(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0000100(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[i, j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[i, j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0000011(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0000010(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d[i] + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0000001(y, T, Z, H, RQR, a1, P1, c, d, missing) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
      if (! int_step(missing[i, j])) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
      } \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ_0000000(y, T, Z, H, RQR, a1, P1, c, d) \
{ \
  real KALMAN_SEQ_v; \
  vector[rows(T)] KALMAN_SEQ_K; \
  real KALMAN_SEQ_Finv; \
  vector[rows(T)] KALMAN_SEQ_a; \
  matrix[rows(T), rows(T)] KALMAN_SEQ_P; \
  vector[rows(T)] KALMAN_SEQ_M; \
  real KALMAN_SEQ_F; \
  KALMAN_SEQ_a <- a1; \
  KALMAN_SEQ_P <- P1; \
  for (i in 1:dims(y)[1]) { \
    for (j in 1:dims(y)[2]) { \
       \
        vector[m] KALMAN_SEQ_Zj; \
        KALMAN_SEQ_Zj <- Z[j]'; \
        KALMAN_SEQ_v <- y[i, j] - c[j] - dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_a); \
        KALMAN_SEQ_M <- KALMAN_SEQ_P * KALMAN_SEQ_Zj; \
        KALMAN_SEQ_F <- dot_product(KALMAN_SEQ_Zj, KALMAN_SEQ_M) + H[j]; \
        KALMAN_SEQ_Finv <- 1 / KALMAN_SEQ_F; \
        KALMAN_SEQ_K <- KALMAN_SEQ_M * KALMAN_SEQ_Finv; \
        KALMAN_SEQ_a <- KALMAN_SEQ_a + KALMAN_SEQ_K * KALMAN_SEQ_v; \
        KALMAN_SEQ_P <- KALMAN_SEQ_P - KALMAN_SEQ_K * KALMAN_SEQ_M'; \
        KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P');  \
        lp__ <- lp__  - 0.5 * (log(2 * pi())  \
                               + log(KALMAN_SEQ_F) + KALMAN_SEQ_Finv * pow(KALMAN_SEQ_v, 2.0)); \
       \
    } \
    KALMAN_SEQ_a <- d + T * KALMAN_SEQ_a; \
    KALMAN_SEQ_P <- T * KALMAN_SEQ_P * T' + RQR; \
    KALMAN_SEQ_P <- 0.5 * (KALMAN_SEQ_P + KALMAN_SEQ_P'); \
  } \
} \


#define KALMAN_SEQ(y, T, Z, H, RQR, a1, P1, c, d) KALMAN_SEQ_0000000(y, T, Z, H, RQR, a1, P1, c, d)

#define KALMAN_SEQ_T(y, T, Z, H, RQR, a1, P1, c, d) KALMAN_SEQ_1111110(y, T, Z, H, RQR, a1, P1, c, d)

#define KALMAN_SEQ_M(y, T, Z, H, RQR, a1, P1, c, d, missing) KALMAN_SEQ_0000001(y, T, Z, H, RQR, c, d, missing)

#define KALMAN_SEQ_TM(y, T, Z, H, RQR, a1, P1, c, d, missing) KALMAN_SEQ_1111111(y, T, Z, H, RQR, c, d, a1, P1, missing)

