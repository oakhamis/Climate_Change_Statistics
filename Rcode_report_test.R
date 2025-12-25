###### SEA LEVEL ANALYSIS WITH RESPECT TO GREENLAND & ANTARCTICA ICE SHEETS #####

# Importing necessary libraries
library(dplyr)

library(jtools)

library(forecast)

library (moments)

library(broom.mixed)

library(summarytools)

library(PerformanceAnalytics)

##### INPUTTING DATA INTO R & DATA PREPROCESSING #####

sea_level - read.csv(CUsersOmarDesktopApplied StatisticsAssessmentSea_level.csv, sep = ,, header = TRUE)

greenland_mass - read.csv(CUsersOmarDesktopApplied StatisticsAssessmentGreenland_Mass.csv, sep = ,, header = TRUE)

antarctica_mass - read.csv (CUsersOmarDesktopApplied StatisticsAssessmentAntarctica_Mass.csv, sep = ,, header = TRUE)

#----------------------

Sea_level_columns - subset.data.frame(sea_level, 
                                       select = c(Year.decimal, smoothed_GMSL_GIA_A_SM_R, GMSL_cumulative_rise))

colnames (Sea_level_columns) - c(Year, GMSL, GMSL_Cumulative_Rise)

Sea_level_columns$Year - as.integer(Sea_level_columns$Year) 

sea_level_year_mean - Sea_level_columns %% group_by(Year) %% summarise_each(funs(mean))

#----------------------

greenland_mass_columns - subset.data.frame(greenland_mass, select = c(ï..Year.decimal,Greenland_mass_cumulative_loss))

colnames (greenland_mass_columns) - c(Year, Greenland_Mass_Cumulative_Loss)

greenland_mass_columns$Year - as.integer(greenland_mass_columns$Year) 

greenland_mass_year_mean -greenland_mass_columns %% group_by(Year) %% summarise_each(funs(mean))

#----------------------

antarctica_mass_columns - subset.data.frame(antarctica_mass, select = c(ï..Year.decimal,Antarctica_mass_cumulative_loss))

colnames (antarctica_mass_columns) - c(Year, Antarctica_Mass_Loss)

antarctica_mass_columns$Year - as.integer(antarctica_mass_columns$Year) 

antarctica_mass_year_mean -antarctica_mass_columns %% group_by(Year) %% summarise_each(funs(mean))

#----------------------------------------------------------

sea_level_year_mean_93_02 - filter(sea_level_year_mean, (Year= 1993 & Year = 2002))

sea_level_year_mean_03_19 - filter(sea_level_year_mean, (Year= 2003 & Year = 2019))

sea_level_year_mean_93_19 - filter(sea_level_year_mean, (Year= 1993 & Year = 2019))

greenland_mass_year_mean_03_19 - filter(greenland_mass_year_mean, (Year= 2003 & Year = 2019))

antarctica_mass_year_mean_03_19 - filter(antarctica_mass_year_mean, (Year= 2003 & Year = 2019))

sealevel_greenland_03_19 - inner_join(sea_level_year_mean_03_19, 
                                       greenland_mass_year_mean_03_19, 
                                       antarctica_mass_year_mean_03_19,
                                       by = Year)

sealevel_greenland_antarctica_03_19 - inner_join(sealevel_greenland_03_19, 
                                                  antarctica_mass_year_mean_03_19,
                                                  by = Year)
##### 1) Descriptive Statistics #####

MyData_03_19 = sealevel_greenland_antarctica_03_19[,-2]

colnames(MyData_03_19)=c(Year, GMSL_Cumulative_Rise, Greenland_Mass_Cumulative_Loss,
                         Antarctica_Mass_Cumulative_Loss)

descr = descr(MyData_03_19[,-1],
              stats = all, transpose = F )
descr

#-------------------------------------------------------

attach(MyData_03_19)

windows()

par(mfcol=c(1,2))

hist(GMSL_Cumulative_Rise, col =blue, main =GMSL_Cumulative_Rise) 

boxplot(GMSL_Cumulative_Rise, col = blue)

windows()

par(mfcol=c(1,2))

hist(Greenland_Mass_Cumulative_Loss, col =cyan, main =Greenland_Mass_Cumulative_Loss) 

boxplot(Greenland_Mass_Cumulative_Loss, col = cyan)

windows()

par(mfcol=c(1,2))

hist(Antarctica_Mass_Cumulative_Loss, main = Antarctica_Mass_Cumulative_Loss, col =5) 

boxplot(Antarctica_Mass_Cumulative_Loss, col = 5)

##### 2) Correlation #####

chart.Correlation(MyData_03_19[,-1], histogram=T, pch=+)

#-------------------------------------------------------

##### 3) Regression #####

## A) simple regression 

#----------------------

model1 = lm (GMSL_Cumulative_Rise~Greenland_Mass_Cumulative_Loss)

summ(model1,confint = TRUE, digits = 3)

# Check normality (Shapiro-Wilk test)

qqnorm(model1$residuals); qqline(model1$residuals,col=2)

shapiro.test(model1$residuals)

# Check Equal variance  Homoscedasticity 

plot(model1$fitted.values, model1$residuals )

abline (0,0,  col = 3)

# Check include Antarctica_Mass_Cumulative_Loss as an additional predictor. 

plot(Antarctica_Mass_Cumulative_Loss, model1$residuals )

abline(0,0, col=2)

#------------------------------
model2 = lm (GMSL_Cumulative_Rise~Antarctica_Mass_Cumulative_Loss)

summ(model2)

# Check normality (Shapiro-Wilk test)

qqnorm(model2$residuals); qqline(model2$residuals,col=2)

shapiro.test(model2$residuals)

# Check Equal variance  Homoscedasticity 

plot(model2$fitted.values, model2$residuals )

abline (0,0,  col = 3)

# Check include Greenland_Mass_loss as an additional predictor. 

plot(Greenland_Mass_Cumulative_Loss, model2$residuals )

abline(0,0, col=2)


## B) Multiple regression 

#----------------------

model3 = lm (GMSL_Cumulative_Rise~Greenland_Mass_Cumulative_Loss + Antarctica_Mass_Cumulative_Loss)

summ(model3)

# check normality (Shapiro-Wilk test)

qqnorm(model3$residuals); qqline(model3$residuals,col=2)

shapiro.test(model3$residuals)

# Check Equal variance  Homoscedasticity 

plot(model3$fitted.values, model3$residuals )

abline (0,0,  col = 3)

carvif(model3)  # since VIF  10, we can not add the two variables in one model

### The final model

## We will suggest a new model based on a new variable

# New variable = Sum of the two independent variables

SUM_Ice_Mass_Cumulative_Loss = Greenland_Mass_Cumulative_Loss + Antarctica_Mass_Cumulative_Loss

model3 = lm (GMSL_Cumulative_Rise ~ SUM_Ice_Mass_Cumulative_Loss)

cor (GMSL_Cumulative_Rise,SUM_Ice_Mass_Cumulative_Loss)

summ(model3)

# Check normality (Shapiro-Wilk test)

qqnorm(model3$residuals); qqline(model3$residuals,col=2)

shapiro.test(model3$residuals)

# Check Equal variance  Homoscedasticity 

plot(model3$fitted.values, model3$residuals )

abline (0,0,  col = 3)

## Comparing model coefficients visually 

plot_summs(model1, model2, model3, scale = TRUE,
           plot.distributions = TRUE)

export_summs(model1, model2, model3, scale = TRUE)

#-------------------------------------------------------

# Time-series forecasting

# Returns the best ARIMA model according to either BIC value.

# The auto.arima function conducts a search over possible model within the period

# The order constraints provided based on the following reference

# Hyndman, RJ, and Khandakar, Y (2008) Automatic time series forecasting The forecast package for R, Journal of Statistical Software, 26(3).

ts.fit= auto.arima(ts(sea_level_year_mean_93_19$GMSL_Cumulative_Rise, 1993, 2019), ic=bic)

ts.fit

# Check the residuals
checkresiduals(ts.fit,lag=10)

# forecast 1 years (from 2020 to 2021 )
forecast(ts.fit,h=1)

plot(forecast(ts.fit,h=1))
#--------------------------








