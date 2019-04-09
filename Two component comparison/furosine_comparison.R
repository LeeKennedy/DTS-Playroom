# Clean Up environment ---------------------------------------------------
rm(list=ls())

# Packages ---------------------------------------------------------------
library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

# Data Input -------------------------------------------------------------
data.in <- read_excel("C:/Users/leekennedy/Desktop/Furosine.xlsx", 
                      col_types = c("numeric", "date", "date", 
                                    "text", "text", "text", "text", "text", 
                                    "text", "text", "text", "text", "text", 
                                    "text", "text", "text", "text", "text", 
                                    "numeric"))

## Data Cleaning ---------------------------------------------------------

# Remove duplicates ------------------------------------------------------

idf <- data.in %>%
        filter(ANALYSIS == "FURO011204")
idf <- idf[!duplicated(idf$SAMPLE_NUMBER),]

misc <- data.in %>%
        filter(ANALYSIS == "MISC011196") 

misc <- misc[!duplicated(misc$SAMPLE_NUMBER),]

# Remove fat results that do not have a density --------------------------
data.all <- misc %>%
        filter(SAMPLE_NUMBER %in% idf$SAMPLE_NUMBER)

# Combine ands simplify --------------------------------------------------
data.all2 <- rbind(data.all, idf)

data.in_3 <- data.all2[, c(1,5,8)]
#data.in_3 <- data.all2[, c(1,4,7)]

data.in_4 <- spread(data.in_3, ANALYSIS, ENTRY)

data.in_4 <- na.omit(data.in_4)
write.csv(data.in_4, "Furosine_comparison.csv")
