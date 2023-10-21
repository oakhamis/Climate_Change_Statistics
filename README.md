# MEASURING THE EFFECT OF MELTING GREENLAND & ANTARCTICA ICE SHEETS ON RISING SEA LEVEL

This analysis aims to understand the relationship between the rise of sea levels and the melting of ice sheets in Greenland and Antarctica.

## Prerequisites

For this analysis, you need to have the following R libraries installed:

- dplyr
- jtools
- forecast
- moments
- broom.mixed
- summarytools
- PerformanceAnalytics

## Data Loading and Preprocessing

Datasets used in this analysis:

1. `Sea_level.csv`: Contains information about sea levels.
2. `Greenland_Mass.csv`: Contains data about the mass of Greenland's ice sheets.
3. `Antarctica_Mass.csv`: Contains data about the mass of Antarctica's ice sheets.

The datasets are loaded into R and undergo preprocessing to ensure the data columns are correctly formatted and named.

## Descriptive Statistics

Descriptive statistics are calculated for sea levels, Greenland's ice sheet mass, and Antarctica's ice sheet mass. Histograms and box plots are generated for each dataset to visualize the distribution of data.

## Correlation

Correlation is assessed between sea levels rise and the mass of ice sheets in both Greenland and Antarctica.

## Regression Analysis

Regression models are built to understand the relationship between sea levels and ice sheet mass:

1. Simple regression models for sea levels against Greenland's ice sheet mass and Antarctica's ice sheet mass separately.
2. Multiple regression model with both Greenland's and Antarctica's ice sheet mass as predictors.
3. Another regression model using the sum of both ice sheet masses as a predictor.

Model diagnostics are performed, including checks for normality, equal variance, and multicollinearity.

## Time-Series Forecasting

The best ARIMA model is identified based on the BIC value to forecast future sea levels.

## Acknowledgment 

- Sea Level Dataset: GSFC. (2020). Global Mean Sea Level Trend from Integrated Multi-Mission Ocean Altimeters TOPEX/Poseidon, Jason-1, OSTM/Jason-2 Version 5.0 Ver. 5.0 PO.DAAC, CA, USA.
- Ice Sheets Datasets: Wiese, D. N., D.-N. Yuan, C. Boening, F. W. Landerer, and M. M. Watkins (2019) JPL GRACE and GRACE-FO Mascon Ocean, Ice, and Hydrology Equivalent Water Height RL06M CRI Filtered Version 2.0, Ver. 2.0, PO.DAAC, CA, USA.
