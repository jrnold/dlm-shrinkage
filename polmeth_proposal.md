Title: Modeling Changepoints by Time-Varying Parameters and Sparse Priors

Proposal: This paper proposes a new, flexible Bayesian method to
estimate changepoints or structural breaks. It does so by combining
existing time-varying parameter methods, such as linear dynamic
models, with heavy-tailed, sparsity inducing distributions from the
Bayesian variable selection literature. In particular, this paper will
use horseshoe prior distribution of Carvalho, Polson and Scott (2010).

This method differs from most approaches to estimating structural
breaks in that instead of trying to simultaneously estimate the number
of breaks, locations of breaks, values of the parameters within each
break, this method models structural breaks through the distribution of
the innovations in a time-varying parameter.  Suppose a parameter,
theta, is time varying, such that theta_t = theta_{t-1} + epsilson_t,
where epsilon_t is a random variable. If theta is time-invariant,
epsilon = 0 for all t. In linear dynamic models, epsilon is given a
normal distribution, which allows theta to “smoothly” vary over time.
The traditional structural break approach is equivalent epsilon having
a distribution mixing between 0 and a diffuse distribution, i.e. a
spike and slab distribution. The use of a mixture model is
conceptually problematic, since from a Bayesian perspective a
parameter is never exactly zero, and it can also be computationally
problematic.

Structural break estimation can be easily incorporated into
time-varying estimation by treating the estimation of epsilson_t as a
shrinkage or variable selection problem.  What is required to model
structural breaks is a distribution which shrinks small values towards
0, but has tails heavy enough to allow for large values, which will be
the “changepoints”. Although there are many distributions used in
Bayesian shrinkage and variable selection, this paper will use the
recently introduced horseshoe prior distribution.  The horseshoe prior
distribution is a mixture of normal distributions that although
continuous, behaves similarly to a spike and slab distribution. Thus
changepoints can be estimated by assigning epsilon a horseshoe prior
distribution; the changepoints simply points with large values of
epsilon. Identifying changepoints is facilitated by a feature of
the horseshoe prior distribution; it produces a quantity which can be
interpreted as the probability that the parameter is non-zero in a
mixture model.  Note that this method does not require the researcher
to specify ex ante the number of structural breaks. The level of
sparsity, which is equivalent to the number of structural breaks, can
be estimated from the data.  The horseshoe prior is also able to adapt
to varying levels of sparsity.

This method has many appealing features.  It is flexible; it can be
used to model any continuous parameter, as well as changes in slope
and higher level derivatives in addition to level changes in the
parameters. It is simple to implement, requiring only a few lines of
code in general purpose Bayesian software, such as BUGS or Stan. It is
also computationally efficient in many cases.  Since the horseshoe
distribution is a mixture of normal distributions, Kalman-like filters
can be used in its estimation. In short, this method is simple and
flexible alternative approach to identifying and estimating
structural breaks.

