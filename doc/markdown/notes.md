# Data

- Nile River data. @ZeileisKleiberKramerEtAl2003
- UK Road Deaths from Harvey and Durbin, 2 breaks. @ZeileisKleiberKramerEtAl2003
- Index of oil prices in Germany, quarterly 1960-1991. @ZeileisKleiberKramerEtAl2003, Multiple breaks. ``strucchange::OilPrice``.
- US Real Interest Rates. ``strucchange::RealInt``
- datasets in R package **strucchange**
- @KillickEckley2014

   - GBM
   - Irish wind speed
   - ``datasets::discoveries``

- blocks, heavisine data: @DonohoJohnstone1994
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
   - monitorM1 (GermanM1):   German M1 Money Demand
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

@BarryHartigan1992 20 "scenes. Also used in **bcp**. See ErdmanEmerson2007 for the scenes.
Compared using MSE.


# Comparisons

- @BarryHartigan. Average MSE of estimators

# Lit Review

Some good overviews are

- overview: 

   - @ZeileisLeischHornikEtAl2002, discusses Dynamic Programming
   - bcp packge: dynamic programming, circular binary segmentation, bayesian product partition
   - strucchange package: @KimTrusinaMinnhagenEtAl2004
   - Citations for introduction : http://www.changepoint.info/introduction.html
   - @JandhyalaFotopoulosMacNeillEtAl2013 is a recent overview

- *PELT* @KillickEckleyEwansEtAl2010, @KillickFearnheadEckley2012
- *Least squares estimator* @Yao1984
- *Dynamic programming*, *segment neighborhood algorithm*:  @BaiPerron1998, @Bai1997, @BaiPerron2003. For minimum segment length or maximum number of breaks,
obtain optimal break point locations by minimizing within segment sums of squares, using a dynamic programming algorithm
- Implemtations of the dynamic programming algorithm in the R package **strucchange**: @ZeileisKleiberKramerEtAl2003, @ZeileisLeischHornikEtAl2002
- *Binary segmentation* @SenSrivastava1975, @ScottKnott1974
- *Circular binary segmentation*, a variant of binary segmentation. @OlshenVenkatramanLucitoEtAl2004
- Total Variation / Lasso penalties

   - @HarchaouiLevy-Leduc2010 proposes total variation
   - @ChanYauZhang2014 Using Group LASSO for structural break AR model
   - Fused Lasso gives examples that are essentially structural breaks.
   - @RojasWahberg2014 Fused Lasso

- Fused Lasso is used for Trend Filtering (of which change points are a 0-polynomial):

   - @KimKohBoydEtAl2009
   - @Tibshirani2014

Also see

G. Ciuperca. A general criterion to determine the number of change-points. Statistics &
Probability Letters, 81:1267–1275, 2011.
G. Ciuperca. Model selection by LASSO methods in a change-point model. Statistical
Papers, 55:349–374, 2014.
- Donoho and Johnstone using wavelet shrinkage for function approximation.

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
- Chib algorithm
- @Lavielle2005

# Software

The changepoint repository <http://www.changepoint.info/>. 

## R package

- **bcp**
- **strucchange**
- **changepoint**: @KimTrusinaMinnhagenEtAl2004
- **cpm** sequential non-parametric change
