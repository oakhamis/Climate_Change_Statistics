# Sea Level Analysis with Respect to Greenland & Antarctica Ice Sheets

This analysis aims to understand the relationship between sea levels and ice sheets in Greenland and Antarctica.

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

Correlation is assessed between sea levels and the mass of ice sheets in both Greenland and Antarctica.

## Regression Analysis

Regression models are built to understand the relationship between sea levels and ice sheet mass:

1. Simple regression models for sea levels against Greenland's ice sheet mass and Antarctica's ice sheet mass separately.
2. Multiple regression model with both Greenland's and Antarctica's ice sheet mass as predictors.
3. Another regression model using the sum of both ice sheet masses as a predictor.

Model diagnostics are performed, including checks for normality, equal variance, and multicollinearity.

## Time-Series Forecasting

The best ARIMA model is identified based on the BIC value to forecast future sea levels.

## Visualizations

Various plots and visualizations are generated throughout the analysis to aid understanding and interpretation of the data and results.
