# Introduction

This paper proposes modeling structural breaks within the same
modeling framework as shrinkage priors and variable selection. 

Consider the following dynamic system,
$$
\begin{aligned}
y_t &= \mu_t + \epsilon_t \\
\mu_t &= \mu_{t-1} + \eta_t
\end{aligned}
$$
where $E(\epsilon_t) = 0$.
If $\mu$. is not time-varying, i.e. no structural breaks, then $\eta_t
= 0$ and the system
reduces to $y_t = \mu + \epsilon_t$.

Modeling structural breaks can be seen as a choice on the distribution
on $\nu_t$.  

The problem of finding structural breaks is similar to that of
variable selection. For most times, $\nu_t \approx 0$, but in some
cases can be $\nu \neq 0$.
This can be thought of as a mixture distribution for $\eta$,
$$
\begin{aligned}
\eta_t &\sim (1 - p) \delta_{\{0\}} + p N(0, \tau^2)
\end{aligned}
$$
The number of structural breaks is controlled by the sparsity
parameter $p$. Typically, the researcher is interested in very few
structural breaks, $p \to 0$, and does not shrink the estimates of the
change in the mean at all, $\tau \to \infty$. 

The commonly used Gaussian linear dynamic system assumes a normal
distribution for $\eta_t$. Since the normal distribution does not have
heavy tails, this allows for more smoothly varying values of $\mu$.

The solution is to use a distribution that shrinks noise towards 0,
but does not shrink signals.
The horseshoe prior, introduced in [@Carvalho2009] is a shrinkage
prior which has this property.
It is defined as,
$$
\begin{aligned}
\eta_t &\sim N(0, \sigma^2 \lambda^2 \tau^2) \\
\lambda &\sim C^+(0, 1)
\end{aligned}
$$
where $C^+(0, 1)$ is a standard half-Cauchy distribution on the positive
reals with scale $s$.

Compared with other sparseness priors, e.g. Normal, Cauchy, Laplacian,
Strawderman-Berger, and Normal-Exponential-Gamma, the Horseshoe
exhibits: tail robustness, unboundedness at the origin, and global
adaptivity to different sparseness patterns [@Carvalho2009, p. 7]. 

Moreover, [@Carvalho] shows that although the horseshoe prior is not a
two-group model, it performs similarly to a two-group model.

# Comparison

# Examples

# Extensions


