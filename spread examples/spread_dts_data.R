# Clean Up environment ---------------------------------------------------
rm(list=ls())

# Packages ---------------------------------------------------------------
library(tidyverse)
library(readxl)

# Data Input -------------------------------------------------------------

data.in <- read_excel("~/Desktop/DTS17058511.xlsx", 
                      sheet = "DTS17058511")

# Data Cleaning ----------------------------------------------------------

tests_of_interest <- c("Calcium", "Free Chlorine", "pH")

# filter to tests of interest --------------------------------------------
data.in2 <- data.in %>% 
        filter(REPORTED_NAME %in% tests_of_interest)

# filter to columns of interest ------------------------------------------
data.in2 <- as.data.frame(data.in2[,c(1,5,7)])

# spread data ------------------------------------------------------------
data.in3 <- spread(data.in2, REPORTED_NAME, ENTRY)

# Optional - convert to numeric and round --------------------------------
data.in3$Calcium <- sapply(data.in3$Calcium, as.numeric)

is.num <- sapply(data.in3, is.numeric)
data.in3[is.num] <- lapply(data.in3[is.num], round, 2)

# data outout ------------------------------------------------------------
data.in3

# Spread the other way ---------------------------------------------------

data.in4 <- spread(data.in2, SAMPLE_NUMBER, ENTRY)

data.in4
