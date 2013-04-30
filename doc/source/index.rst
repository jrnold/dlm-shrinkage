.. Scale Mixture Normal DLMs documentation master file, created by
   sphinx-quickstart on Tue Apr 30 19:12:31 2013.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Scale Mixture Normal DLMs's documentation!
=====================================================

Classic Data Sets
==================

Classic data sets from the state space and time series literature.

- Flow of the Rive Nile. `datasets::AirPassengers`
- Box and Jenkins Airline data. `datasets::AirPassengers`
- Road Casualties in Great Britain. `datasets::UKDriverDeaths`
- UK Marriage Data. West and Harrison. Chapter 11.
- CP6 Sales Data. West and Harrison. Chapter 11.
- Industrial Production Data. West and Harrison. Chapter 11.
- UK Quarterly Gas Consumption. Petris and Petrone, Chapter 4.5
  `datasets::UKgas`.
- Coal Mining Disasters (poisson change point)


Comparison
=============

Ratkovic

- plot fit against data
- MSE
- time-series plot of residuals
- qq-plot of residuals
- autocorrelation of residuals

Sources
==============

- See http://arxiv.org/pdf/1109.2279v2.pdf
- Armagan, Dunson, and Clyde  "Generalized Beta Mixtures of Gaussians"
- Polson and Scott, "Good, Great, Or Lucky? Screening For Firms With Sustained Superior Performance Usingheavy-Tailed Priors"


Political Science Papers
========================

Western and Kleykamp (2004). Bayesian model for 1 change point per parameter.

Normal Distribution
====================

Mean of the normal distribution with a normal prior (Jackman 2009, Proposition 2.4, p. 81)

.. math::

   y_i \sim N(\mu, \sigma^2)
   \mu \sim N(\mu_0, \sigma^2 \sigma_0^2)

Then,

.. math::

   \mu | y \sim N \left( \frac{\mu_0 \sigma_0^{-2} \sigma^{-2} + \bar y \frac{n}{\sigma^2}}{\sigma_0^{-2} \sigma^{-2} + \frac{n}{\sigma^2}}, \left(\sigma_0^{-2} \sigma^{-2} + n \sigma^{-2})^{-1} \right) 
   \sim N \left(\frac{\mu_0 \sigma_0^{-2} + \bar y n}{\sigma_0^{-2}  + n}, \left(\sigma_0^{-2} + n)^{-1} \sigma^{2} \right)

In the special case :math:`\mu_0 = 0, \bar y = y, n = 1`,

.. math::

   \mu | y \sim N \left( \frac{1}{\sigma_0^{-2} + 1} y, \frac{1}{\sigma_0^{-2} + 1}\sigma^2 \right)

Scale-Mixture of Normal Distributions
=======================================

Suppose :math:`\psi^2 = \lambda_t^2 \tau^2`

.. math::
   
   y &\sim N(\mu_t, \sigma^2) \\
   \mu_t & \sim N(\mu_{t - 1}, \psi^2)

and then, rearranging terms,

.. math::
   
   e_t = y_t - \mu_{t - 1} &\sim N(\Delta \mu_t, \sigma^2) \\ 
   \Delta \mu_t & \sim N(0, \psi^2)

The system of equations, conditioning on :math:`\mu_{t-1}`, :math:`\sigma^2` and :math:`\psi^2`, 
using the standard result for a normal distribution with normal prior for the mean (Jackman 2009, p. 81),

.. math::

   \Delta \mu_t &\sim N\left( \frac{e_t \sigma^{-2}}{\psi^{-2} + \sigma^{-2}}, \frac{e_t \sigma^{-2}}{\psi^{-2} + \sigma^{-2}}  \right)

The expected value can be written as a weighted average of the observation and difference between
the observation and the prior. Let :math:`\lambda = \frac{\psi^{-2}}{\psi^{-2} + \sigma^{-2}} = \frac{\sigma^2}{\sigma^2 + \psi^2}`,

.. math::

   E(\Delta \mu_t | y, .) &= e_t + \lambda(0 - e_t) \\
   &= (1 - \lambda) e_t

Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
