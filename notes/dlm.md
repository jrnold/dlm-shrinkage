---
title: DLMs in Stan
author: "Jeffrey Arnold"
date: "September 2, 2015"
output: html_document
---


Following the notation of Petris and Petrone (p. 41), a DLM is defined as,
For $t = 1, \dots, n$,
$$
\begin{aligned}[t]
y_t &\sim N(b_t + F_t' \theta_t, V_t) \\
\theta_t &\sim N(g_t + G_t \theta_{t-1}, W_t) \\
\theta_0 &\sim N(m_0, C_0)
\end{aligned}
$$
where $G_t$ is $p \times p$ matrix, $F_t$ is a $p \times 1$ vector, $\theta_t$ is a $p \times 1$ vector, and $W_t$ is a $p \times p$ matrix.
I will assume a univariate $y_t$.

## Filter

The Kalman filtering equations (Petris et al., p. 53; West Harrison, p 103)
$$
\begin{aligned}[t]
a_t &= E(\theta_t | y_{1:t-1}) &&= g_t + G_t m_{t-1} \\
R_t &= Var(\theta_t | y_{1:t-1}) &&= G_t C_{t-1} G'_t + W_t \\
f_t &= E(Y_t | y_{1:t-1}) &&= b_t + F_t' a_t \\
Q_t &= Var(Y_t | y_{1:t-1}) &&= F_t' R_t F_t + V_t \\
e_t &= \text{forecast error} &&= y_t - f_t \\
K_t &= \text{Kalman gain} &&= R_t F_t Q_t^{-1} \\
m_t &= E(\theta_t | y_{1:t}) &&= a_t + R_t F_t' Q_t^{-1} e_t \\
& &&= a_t  + K_t e_t \\
C_t &= Var(\theta_t | y_{1:t}) &&= R_t - R_t F_t' Q_t^{-1} F_t R_t \\
& &&= R_t - K_t Q_t K_t'
\end{aligned}
$$

## Log-likelihood

$$
\begin{aligned}[t]
L(Y_n) &= - \frac{1}{2} \sum{t = 1}^{n} \left( r \log(2 \pi) + \log\lvert Q_t\rvert + e'_t Q_t^{-1} e_t \right) \\
       &= - \frac{r p}{2} \log(2 \pi) - \frac{1}{2} \sum{t = 1}^{n} \left(\log\lvert Q_t\rvert + e'_t Q_t^{-1} e_t \right) \\
       &= - \frac{r p}{2} \log(2 \pi) - \frac{1}{2} \sum{t = 1}^{n} \left(- \log \lvert Q^{-1}_t \rvert + e'_t Q_t^{-1} e_t \right)
\end{aligned}
$$
where the last line follows from the matrix identity $\lvert A \rvert = \frac{1}{\lvert A^{-1} \rvert}$.

This is easily adjusted for the univariate case, and for missing values.

## Backward Smoother

The FFBS (Petris et al., p. 161-162):
$$
\begin{aligned}[t]
h_t &= m_t + C_t G_{t+1}' R_{t+1}^{-1} (\theta_{t + 1} - a_{t + 1}) \\
H_t &= C_t - C_t G'_{t + 1} R^{-1}_{t + 1} G_{t + 1} C_t
\end{aligned}
$$

- Draw $\theta_T \sim N(m_T, C_T)$
- For $t = T - 1, \dots, 0$, draw $\theta_t \sim N(h_t, H_t)$

This is the "naive" algorithm first proposed byu Fruhwirth-Schnatter (1994) and Carter and Kohn (1994).
Later, de Jong and Shepherd (1995) and then, Durbin and Koopmans (2002), present simulation methods based on innovation smoothing that are more efficient.

## Smoothing

(Petris et al., p. 62)

Define $s_t = E(\theta_t | y_{1:T})$ and $S_t = Var(\theta_t | y_{1:T})$.
Let $s_T = m_T$ and $S_T = C_T$, then for $n - 1, \dots, 0$, 
$$
\begin{aligned}[t]
s_t &= m_t + C_t G_{t+1}' R_{t+1}^{-1} (s_{t + 1} - a_{t + 1}) \\
s_t &= C_t - C_t G'_{t + 1} R^{-1}_{t + 1} (R_{t + 1} - S_{t + 1}) R^{-1}_{t + 1} G_{t + 1} C_t
\end{aligned}
$$


# Random walk

A special case is the random walk, 
$$
\begin{aligned}[t]
y_t &\sim N(\theta_t, V_t) \\
\theta_t &\sim N(\theta_{t-1}, W_t)
\end{aligned}
$$
The filter simplifies to 
The Kalman filtering equations (Petris et al., p. 53; West Harrison, p 103)
$$
\begin{aligned}[t]
a_t &= E(\theta_t | y_{1:t-1}) &&= m_{t-1} \\
R_t &= Var(\theta_t | y_{1:t-1}) &&= C_{t-1} + W_t \\
f_t &= E(Y_t | y_{1:t-1}) &&= a_t \\
Q_t &= Var(Y_t | y_{1:t-1}) &&= R_t + V_t \\
e_t &= \text{forecast error} &&= y_t - f_t \\
K_t &= \text{Kalman gain} &&= \frac{R_t}{Q_t} = \frac{R_t}{R_t + V_t} = \frac{C_{t-1} + W_t}{C_{t-1} + W_t + V_t} \\
m_t &= E(\theta_t | y_{1:t}) &&= a_t + \frac{R_t}{Q_t} e_t = a_t  + K_t e_t \\
C_t &= Var(\theta_t | y_{1:t}) &&= R_t - \frac{R_t^2}{Q_t} = R_t - K_t^2 Q_t
\end{aligned}
$$




