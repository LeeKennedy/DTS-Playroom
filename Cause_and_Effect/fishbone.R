# Create a fishbone diagram

# Clean Up environment ---------------------------------------------------
rm(list=ls())

# Packages ---------------------------------------------------------------
library(qcc)

# Functions --------------------------------------------------------------

# Data Input -------------------------------------------------------------

data=read.csv("fishbone.csv", as.is=TRUE, header=TRUE)
Effect=data$Effect[1]

# Data Cleaning ----------------------------------------------------------


# Visualising Data -------------------------------------------------------

cause.and.effect(data[,3:8],Effect, title = data$Title[1])