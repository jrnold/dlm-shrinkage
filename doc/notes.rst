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
