# Clear Environment ---------------------------------------------
rm(list=ls())

library(dplyr)
library(ggplot2)

# Data from NMI MU Training Course - Part 2, page 23 --------------------------
data.in <- read.csv("data/Book11.csv", as.is=TRUE)

data.in$Response <- as.numeric(data.in$Response)

y <- data.in$Response
x <- data.in$Conc

fit <- lm(y~x)
sf <- summary(fit)
summary(fit)

fit2 <- lm(x~y)

new <- data.frame(y = 0.8820)

data.out <- predict.lm(fit2, new, se.fit=TRUE, interval = "prediction")
data.out

RSD <- summary(fit)$sigma
m <- summary(fit)$coefficients[2]
N <- 1
n <- nrow(data.in)
y0 <- 0.8820
ybar <- mean(data.in$Response)
x2 <- sum(data.in$Conc^2)
x2a <- sum(data.in$Conc)^2

# Standard Deviation of Prediction---------------------------------------------
sx <- (RSD/m)*sqrt((1/N)+(1/n)+((y0-ybar)^2)/(m^2*(x2-(x2a/n))))
sx                 
2*sx

# Plotting result-------------------------------------------------------------
plot1 <- ggplot(data.in, aes(x=Conc, y=Response)) +
        geom_point(size=4) +
        geom_smooth(method = lm, se = FALSE) +
        geom_abline(slope = 4.1769, intercept = 0.0741, colour = "red") +
        geom_abline(slope = 4.7731, intercept = 0.1755, colour = "red") +
        geom_hline(yintercept = 0.8820) +
        geom_vline(xintercept = data.out$fit[1]) +
        geom_vline(xintercept = data.out$fit[1]-2*sx) +
        geom_vline(xintercept = data.out$fit[1]+2*sx) +
        scale_y_continuous(limits=c(0.7,1))
plot1
