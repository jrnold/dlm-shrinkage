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

