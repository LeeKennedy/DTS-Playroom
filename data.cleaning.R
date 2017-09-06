# Clean Environment ------------------------------------------------------
rm(list=ls())

# Packages used ----------------------------------------------------------
library (dplyr)
library (tidyr)
library (ggplot2)
library (readxl)
library (lubridate)

# Input data -------------------------------------------------------------
#data.in <- read.csv("workbook1.csv", as.is = TRUE)
data.in <- read_excel("Butter5.xlsx")

nrow(data.in)
ncol(data.in)
head (data.in, 10)
tail (data.in, 10)
str(data.in)
summary(data.in)

# Remove non-numeric values & remove any NAs generated -------------------
data.in$ENTRY <- as.numeric(data.in$ENTRY)
data.in <- data.in[!is.na(data.in$ENTRY),]

# Remove rows with no ENTRY value ----------------------------------------
data.in <- data.in[!(data.in$ENTRY == ""),]

# Check on units ---------------------------------------------------------

table(data.in$UNITS,data.in$ANALYSIS)

