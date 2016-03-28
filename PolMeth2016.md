**Title**: Bayesian Change Points and Linear Filtering with Shrinkage Priors

**Author**: Jeffrey Arnold

**Abstract**:  I propose modeling change points, or structural breaks, with Bayesian
shrinkage priors  on differences in time-varying parameters.  Shrinkage priors,
such as the horseshoe prior, are the Bayesian analog of penalized likelihood
procedures, such as the LASSO. This method has several advantageous features.
First, the number of change points is not specified ex ante. Second, it is
similar to most political science data generating processes, in which the
parameter is always changing, but changes are orders of magnitude larger in some
periods than others. Third, It is flexible. The same method extends to change
points in multiple parameters, trends, cycles, linear regression parameters, variance, etc.
Fourth, for many common models, it can be written as a dynamic linear
model (DLM), and efficiently estimated with specialized methods. I apply
this method to several examples, including public opinion and financial market
data.

To implement implement this, I have written a set of functions generally useful for
estimating DLMs with either sampling or optimization. I have implement a suite of functions for filtering, smoothing, and sampling DLMs in Stan, a Bayesian modeling language. These functions are provided as both a
user functions in Stan, and an R package. These allow for efficiently estimating general DLMs with a partially collapsed Gibbs sampler.
