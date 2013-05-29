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

Normal Mean, Normal Prior
=======================================

The result that the scale mixture of normal distributions relies on is the simple conjugate updating of the mean of a normal distribution with a normal prior.
The results are cleaner if the prior variance is multiplied by the likelihood variance.

Let :math:`y \overset{iid}{\sim} N(\mu, \sigma^2)`, with :math:`\sigma^2` known, and :math:`y = (y_1, \dots, y_n)'`. 
If :math:`\mu \sim N(\mu_0, \sigma^2 \sigma_0^2)` is the prior density for :math:`\mu`, then :math:`\mu`, 
then :math:`\mu` has posterior density (Proposition 2.4 from Jackman 2009).

.. math::

   \mu | y \sim N \left( \mu_0 \frac{\sigma_0^{-2} + \bar{y} n}{\sigma_0^{-2} + n}, (\sigma_0^{-2} + n)^{-1} \sigma^2 \right)

In the special case :math:`\mu_0 = 0, \bar y = y, n = 1`,

.. math::

   \mu | y \sim N \left( \frac{1}{\sigma_0^{-2} + 1} y, \frac{1}{\sigma_0^{-2} + 1}\sigma^2 \right)

The posterior mean can be written as a weighted average of the prior and sample mean,

.. math::

   E(\mu|y) = \bar{y} + \lambda(\mu_0 - \bar{y})

where :math:`\lambda \in (0, 1)`

.. math::

   \lambda = \frac{\sigma_0^{-2}}{\sigma_0^{-2} + n} = \frac{1}{1 + n \sigma_0^{2}}


In the case that :math:`\mu_0 = 0` (shrinkage prior), 

.. math::

   E(\mu|y) = (1 - \lambda) \bar{y}

Thus :math:`\lambda` is a shrinkage parameter. When :math:`\lambda \to
1`, :math:`E(\mu|y) \to 0` and when :math:`\lambda \to 0`,
:math:`E(\mu|y) \to \bar{y}`.

Multivariate
=======================

Rearrange the state space model

.. math::

   Z(\alpha_t - d - T \alpha_{t-1}) = Z \eta
   
   y - c - Z(d - T \alpha_{t - 1}) = Z(\alpha_t - d - T \alpha_{t - 1}) + \epsilon

Define, :math:`\tilde \eta = Z \eta`, and :math:`\tilde y = y - c - Z(d - T \alpha_{t - 1})`,
and :math:`\tilde Q = Z R Q R' Z'`.

.. math::

   \tilde \eta \sim N(0, \tilde Q)

   \tilde y \sim N(\tilde \eta, H)

The mean of the posterior distribution is thus,

.. math::

   E \tilde \eta | y = W \tilde y

   W = (\tilde Q^{-1} + H^{-1})^{-1} H^{-1} \tilde y

where W is a weight. 


Identifying Structural Breaks
==============================

Structural breaks / outliers can be identified in three ways.

Given that the parameter is 

.. math::
   
   \eta_t \sim N(0, \tau \lambda_t)

1. With respect to the mixture model, e.g. as in Carvalho et. al. This 
   is problematic in hiearchical parameters.
2. As in Petris et al., if :math:`\lambda_t = 1` then :math:`\eta_t` is 
   distributed normal. when :math:`\lambda_t > 1` then the parameter is 
   over-distributed. i.e. an outlier. However, Petris et al do not consider 
   under distributed values.
3. Similar to Petris / Petrone. However, calculate the probability of the 
   parameter if it were distributed normal, without the mixture term.
   :math:`N(0, \tau)`.



Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
