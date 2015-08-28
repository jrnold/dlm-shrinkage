---
...
# Data

- Nile River data. @ZeileisKleiberKramerEtAl2003, ``datasets::Nile``
- UK Road Deaths from Harvey and Durbin, 2 breaks. @ZeileisKleiberKramerEtAl2003, ``datasets::UKDriverDeaths``
- Index of oil prices in Germany, quarterly 1960-1991. @ZeileisKleiberKramerEtAl2003, Multiple breaks. ``strucchange::OilPrice``.
- US Real Interest Rates. ``strucchange::RealInt``
- datasets in R package **strucchange**
- @KillickEckley2014

    - GBM
    - Irish wind speed
    - ``datasets::discoveries``

- Set of 4 functional datasets used in @Fearnhead2005a, @DonohoJohnstone1994, @DonohoJohnstone1995a, @DenisonMallickSmith1998, 

    - Blocks
    - Heavysine
    - Bumps
    - Doppler


Example in Ratkovic

$$
\begin{aligned}
sim_{jump}(x_i) = -2 f(x_i / 100) + 8 I(x_i > 200) - 4 I (x_i > 500) + 2 I (x_i > 800) + u_i \\
sim_{nojump}{x_i} = -s f (x_i / 100) + u_i
\end{aligned}
$$

with

- Gaussian noise: $var(u_i) \in \{1, 4\}$, $cor(u_i, u_{i-1} = 0$.
- AR(1) noise: $var(u_i) \in \{1, 4\}$, $cor(u_i, u_{i-1} = 0.4$
- Sample sizes $n \in \{100 ,200, 500\}$
- $f$ is a Bessel function of the 2nd type


Comparisons: Kalman filter (`StructTS` in R **stats**), and smoothing spline (`ssanova()` in R **gss**) and R package.

- **changepoint**

	- HC1:                     G+C Content in Human Chromosome 1
	- Lai2005fig3:             Normalized glioblastoma profile 13
	- Lai2005fig4:             Normalized glioblastoma profile for an excerpt of chromosome 7, the EGFR locus.
	- ftse100:                 FTSE 100 Daily Returns: 2nd April 1984 - 13th September 2012
	- wave.c44137:             Wave data from buoy c44137

- **strucchange**

	- BostonHomicide:          Youth Homicides in Boston
	- DJIA:                    Dow Jones Industrial Average
	- GermanM1:                German M1 Money Demand
	- Grossarl:                Marriages, Births and Deaths in Grossarl
	- PhillipsCurve:           UK Phillips Curve Equation Data
	- RealInt:                 US Ex-post Real Interest Rate
	- SP2001:                  S&P 500 Stock Prices
	- USIncExp:                Income and Expenditures in the US
	- durab:                   US Labor Productivity
	- historyM1 (GermanM1):    German M1 Money Demand
	- monitorM1 (GermanM1):    German M1 Money Demand
	- scPublications:          Structural Change Publications

- **bcp**

   - RealInt: US ex-post real interest rate: the three-month treasury bill deflated by the CPI inflation rate, 1961 to 1986
   - coriell: two data array CGH studies of Corriel cell lines


## Simulations

@Yao1984, 100 samples of T = 20. Variance = 1.
Twelve simulations are run.

| levels     | change    |
|------------|-----------|
| 0          | none      |
| 0,1        | 10        |
| 0,3        | 10        |
| 0,5        | 10        |
| 0,2,4      | 4,10      |
| 0,3,0      | 5,15      |
| 0,1,2,3    | 4,10,16   |
| 0,1,0,1    | 4,10,16   |
| 0,1,3,4,6  | 3,7,12,16 |
| 0,3,-3,6,0 | 3,7,12,16 |

and additional

- $\mu_t = n - 1, 1 \leq n \leq 11$, $\mu n = 21 - n, 12 \leq n \leq 20$
- $\mu_t = 10 - 0.1 (n - 11)^2, 1 \leq n \leq 20$

@BarryHartigan1992 20 "scenes". Also used in **bcp**. See ErdmanEmerson2007 for the scenes.
Compared using MSE.


## Political Science Examples

- @CalderiaZorn1998
- @WesternKleykamp2004
- @Park2010
- @Park2011
- @Spirling2007b
- @Spirling2007a

## Bayesian

- @BarryHartigan1992 Using a product partition to calculate change points.
- @ErdmanEmerson2008, @ErdmanEmerson2007 Implement a fast version of the @BarryHartigan1992 algorithm in the R package **bcp**
- @Fearnhead2006
- @Chib1998
- @Lavielle2005

# Software

The changepoint repository <http://www.changepoint.info/>. 

### Changeponts


## Citations

### Shrinkage

- Dirichlet-Laplace Priors: @BhattacharyaPatiPillaiEtAl2014
- Generalized Double-Pareto: \cite{ArmaganDunsonLee2013a}
- Horseshoe: [@CarvalhoPolsonScott2010, @CarvalhoPolsonScott2009, @DattaGhosh2012, @BhadraDattaPolsonEtAl2015a, @PasKleijnVaart2014a]

    - A simple sampler for the horseshoe estimator: MakalicSchmidt2015a

- Three-parameter beta: Armagan et al
- Normal-exponential-gamma: @BrownGriffin2010
- Bridge
- Lasso
- Normal-Jeffreys
- On half-Cauchy as global scale parameter: @PolsonScott2012


### Changepoint


## R packages

- **changepoint**: @KillickEckley2014 . Mean, variance, and mean-variance changepoints using: binary segmentation, segment neighborhood, PELT
- **strucchange**
- **bcp** Bayesian change-point estimator
- **cpm** sequential non-parametric change
- **sde**
- MCMCpack functions for changepoints in linear normal, Poisson, ordered probit, and probit models: MCMCbinaryChange, MCMCoprobitChange, MCMCpoissonChange, MCMCregressChange
- Hidden Markov Models for ChibAlgorithm: depmixS4

### Software for Dynamic linear models

- JSS issue on dynamic models: @CommandeurKoopmanOoms2011, @petris2011state
- Overview of Kalman filters in R: @Tusell2011
- R packages

    - DLM: @Petris2010a
    - KFAS
    - sspir
    - FKF
    - dse: 
    - StructTS in base R

### Texts or Overviews of Dynamic Linear Models

- @Harvey1990
- @WestHarrison1997
- @ShumwayStoffer2010
- @DurbinKoopman2012
- @CommandeurKoopman2007
- @PetrisPetroneEtAl2009



## Misc

- FFBS: @CarterKohn1994, @Fruehwirth-Schnatter1994
- Simulation smoother: @DeJongShephard1995
- Mean correction simulation smoother: @DurbinKoopman2002
- Sequential simulation smoother: @StricklandTurnerDenhamEtAl2009
- Equivalence between state space models and ARMA: @Gilbert1993a 


