# Environment clean ------------------------------------------------------
rm(list=ls())

# Packages ---------------------------------------------------------------
library(MASS)
library(psych)
library(ggplot2)
library(pwr)

# Data in ----------------------------------------------------------------
attach(anorexia)

# Inspect data -----------------------------------------------------------
head(anorexia)

describe(anorexia$Prewt)
describe(anorexia$Postwt)

# Create differences ----------------------------------------------------
weight.differences = Postwt - Prewt

# Boxplot differences - looking for outliers ----------------------------
boxplot(weight.differences, 
        main = "Boxplot of differences",
        ylab = "Weight differences",
        col = "green")

#attach weight.differences to anorexia data frame ------------------------
anorexia$weight.differences = weight.differences


# Plot histogram with density curve --------------------------------------
ggplot(anorexia,aes(x=weight.differences)) + 
        geom_histogram(aes(y=..density..),binwidth = 0.9) + 
        stat_function(fun = dnorm, 
                      colour = "blue",
                      args = list(mean = mean(anorexia$weight.differences), 
                                  sd = sd(anorexia$weight.differences))) + 
        scale_x_continuous(name="Weight differences") + 
        ggtitle("Histogram of weight differences before and after anorexia treatment")

#Test if the weight differences are normally distributed -----------------
shapiro.test(weight.differences)

# Perform a power analysis to check the sample size has adequate power----
# to detect a difference if it exists-------------------------------------
# Can the test find a difference of 0.5sd (d)?---------------------------- 
pwr.t.test(n=72,d=0.5,sig.level = 0.05,type = c("paired"))

#Perform a paired t test -------------------------------------------------
t.test(Postwt,Prewt,paired = TRUE)

#Interpret results
#All assumptions required were satisfied
#There were no outliers, data was normally distributed and the t test had adequate power
#The difference in weight before and after treatment was statistically significant at 5% LOs. 
