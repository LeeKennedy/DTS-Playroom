# Clean Up environment ---------------------------------------------------
rm(list=ls())

# Packages ---------------------------------------------------------------
library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

# Data Input -------------------------------------------------------------
data.in <- read_excel("cream.xlsx")

## Data Cleaning ---------------------------------------------------------

set <- unique(data.in$ANALYSIS)


# Remove duplicates ------------------------------------------------------

data.A <- data.in %>%
        filter(ANALYSIS == set[1])
data.A <- data.A[!duplicated(data.A$SAMPLE_NUMBER),]

data.B <- data.in %>%
        filter(ANALYSIS == set[2])
data.B <- data.B[!duplicated(data.B$SAMPLE_NUMBER),]

# Remove fat results that do not have a density --------------------------
data.all_1 <- data.A %>%
        filter(SAMPLE_NUMBER %in% data.B$SAMPLE_NUMBER)

data.all_2 <- data.B %>%
        filter(SAMPLE_NUMBER %in% data.all_1$SAMPLE_NUMBER)


# Combine and simplify --------------------------------------------------
data.all.comb <- rbind(data.all_1, data.all_2)

data.in_3 <- data.all.comb[, c(1,4,7)]

data.in_4 <- spread(data.in_3, ANALYSIS, ENTRY)
colnames(data.in_4)[2] <- "B"
colnames(data.in_4)[3] <- "A"


# Graph ------------------------------------------------------------------

comparison_plot <- ggplot(data.in_4, aes(x=B, y=A)) +
                        geom_point(size=4, shape=21, col = "darkgreen", fill = "beige") +
        labs(x=set[2], y=set[1]) +
        theme_bw()
                        
comparison_plot
