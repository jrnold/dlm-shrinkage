# Model Terminology

These models are called either state space models (econometrics) or dynamic (linear) models (statistics / Bayesian).

The following defines a *state space model*
$$
\begin{aligned}[t]
y_t = f(\theta_t | F_t, \nu_t) \\
\theta_t = f(\theta_{t-1} | G_t, \nu_t)
\end{aligned}
$$
If $\theta_t$ is continuous then it is a *continuous state space model*,
if $\theta_t$ is discrete then it is a *discrete state space model*.

If those equations can be written as 
$$
\begin{aligned}[t]
y_t = F_t \theta_t + \nu_t \\
\theta_t = G_t \theta_{t-1} + \omega_t
\end{aligned}
$$
then the model is a *Dynamic Linear Model (DLM)* (linear SSM), otherwise it is a non-linear dynamic model.
If $\nu_t$ and $\omega_t$ are normal distributions, then it is 
*Guassian* or *Normal Dynamic Linear Model* (GDLM or NDLM).
If $\nu_t$ or $\omega_t$ are 

Another class is *Dynamic Generalized Linear Model*.

# West and Harrison

$$
\begin{aligned}[t]
\Y_t &= F'_t \theta_{t-1} + \nu_t & \nu_t & \sim N(0, V_t) \\
\theta_t &= G_t \theta_{t-1} + \omega_t & \omega_t & \sim N(0, W_t) \\
\theta_0 &\sim N(m_0, C_0)
\end{aligned}
$$

with dimensions $r$ (number of variables), $n$ (number of states),

Matrices, 

matrix        dimensions
------------- ------------
$F_t$         $n \times r$
$G_t$         $n \times n$
$V_t$         $r \times r$
$W_t$         $n \times n$
$C_0$         $n \times n$

and vectors,

vector        dimensions
------------- ------------
$Y_t$         $r \times 1$
$theta_t$     $n \times 1$
$\nu_t$       $r \times 1$
$\omega_t$    $n \times 1$
$m_0$         $n \times 1$

This is initialized with the filtered states.

# Durbin and Koopmans

$$
\begin{aligned}[t]
\y_t &= Z_t \alpha_{t} + \varepsilson_t & \varepsilon_t & \sim N(0, H_t) \\
\alpha_{t+1} &= T_t \alpha_{t} + R_t \eta_t & \eta_t & \sim N(0, Q_t) \\
\alpha_1 &\sim N(a_1, P_1)
\end{aligned}
$$

with dimensions $r$ (number of disturbances), $p$ (number of variables) and $m$ (number of states).

Matrices, 

matrix        dimensions
------------- ------------
$Z_t$         $p \times m$
$T_t$         $m \times m$
$H_t$         $p \times p$
$Q_t$         $r \times r$
$R_t$         $m \times r$
$P_1$         $m \times m$

and vectors,

vector          dimensions
-------------   ------------
$y_t$           $p \times 1$
$\alpha_t$      $m \times 1$
$\varepsilon_t$ $p \times 1$
$\eta_t$        $r \times 1$
$a_1$           $m \times 1$

This is initialized with the filtered states.

# Algorithms

## Local Level


### Filter

### Backward sample

## General

### Filter
