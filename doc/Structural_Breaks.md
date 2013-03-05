% Using the Horseshoe Prior for Structural Breaks
% Jeffrey B. Arnold
% March 4, 2013

# Introduction

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

The commonly used Gaussian linear dynamic system assumes a normal
distribution for $\eta_t$. Since the normal distribution does not have
heavy tails, this allows for more smoothly varying values of $\mu$.

In the case of structural breaks, the values of $\eta_t$ are assumed
to be sparse. Generally, it is believed that there are a small number
of structural break. 
One way to model this is as a a mixture distribution in which $p$ 
$\eta \neq 0$ and are distributed $g(\eta_i)$ and $1 - p$ are equal to 0.
$$
\begin{aligned}
\eta_t &\sim (1 - p) \delta_{0} + p g(\eta_i)
\end{aligned}
$$
The number of structural breaks is controlled by the sparsity
parameter $p$. Typically, the researcher is interested in very few
structural breaks, $p \to 0$, and does not shrink the estimates of the
change in the mean at all, $\tau \to \infty$.

The second approach is to use a sparsity inducing distribution on
$\eta$, such that most values are shrunk towards 0, but a few large
signals exist.  
For this purpose, the distribution of $\eta$ should (1) have heavy
tails and (2) should have a substantial mass near 0.

The horseshoe prior, introduced in [@CarvalhoPolsonScott2010] is a shrinkage
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

This model produces shrinkage weights which act similarly to the
posterior probability of inclusion in a two group model. 
Let $\kappa_t \in [0, 1]$ be defined as
$$
\kappa_t = \frac{1}{1 + \lambda_t^2 \tau_t
$$
The shrinkage weight is 
$$
\omega_t = 1 - \kappa_t
$$.
When $\kappa_t \approx 0$, it identifies signal, and when $kappa_t
\approx 1$, the 


Compared with other sparseness priors, e.g. Normal, Cauchy, Laplacian,
Strawderman-Berger, and Normal-Exponential-Gamma, the Horseshoe
exhibits: tail robustness, unboundedness at the origin, and global
adaptivity to different sparseness patterns
[@CarvalhoPolsonScott2010]. [@PolsonScott2012] note that the horseshoe
prior is one of class of global-local scale mixtures of normals which
can be used for Bayesian regularized regression.

This approach is flexible, easy to implement, and potentially fast.

- It is straight-forward to extend this to structural breaks in slops,
  or regression coefficients.
- For small problems, this can be easily estimated with general purpose 
  Bayesian software, such as BUGS, JAGS, or Stan.
- Since $\eta$ is distributed normal, if the observation errors are
  distributed normal, then system can be efficiently sampled or
  estimated with a Kalman Filter.
- Since this is done on line, Sequential Monte Carlo methods may be
  able to estimate this quickly and potentially identify structural
  breaks in real time.


# Example

West and Harrison example





