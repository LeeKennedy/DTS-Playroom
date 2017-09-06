# Clean Up environment ---------------------------------------------------
rm(list=ls())

# Packages ---------------------------------------------------------------
library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

# Data Input -------------------------------------------------------------
data.in <- read_excel("~/Desktop/cream.xlsx")

## Data Cleaning ---------------------------------------------------------

# Remove duplicates ------------------------------------------------------

data.density <- data.in %>%
        filter(ANALYSIS == "DENS030112")
data.density <- data.density[!duplicated(data.density$SAMPLE_NUMBER),]

data.fat <- data.in %>%
        filter(ANALYSIS == "FATS011299")
data.fat <- data.fat[!duplicated(data.fat$SAMPLE_NUMBER),]

# Remove fat results that do not have a density --------------------------
data.all <- data.fat %>%
        filter(SAMPLE_NUMBER %in% data.density$SAMPLE_NUMBER)

# Combine ands simplify --------------------------------------------------
data.all2 <- rbind(data.all, data.density)

data.in_3 <- data.all2[, c(1,4,7)]

data.in_4 <- spread(data.in_3, ANALYSIS, ENTRY)

# Graph ------------------------------------------------------------------

fat_dens_plot <- ggplot(data.in_4, aes(x=DENS030112, y=FATS011299)) +
                        geom_point(size=4, shape=21, col = "darkgreen", fill = "beige") +
                        geom_smooth(method=loess) +
        theme_bw()
                        
fat_dens_plot
