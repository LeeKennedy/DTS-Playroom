# Clean Up environment ---------------------------------------------------
rm(list=ls())

# Packages ---------------------------------------------------------------
library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

# Data Input -------------------------------------------------------------
data.in <- read_excel("cream2.xlsx")

## Data Cleaning ---------------------------------------------------------

# Remove duplicates ------------------------------------------------------

data.density <- data.in %>%
        filter(ANALYSIS == "DENS030112")
data.density <- data.density[!duplicated(data.density$SAMPLE_NUMBER),]

data.fat <- data.in %>%
        filter(ANALYSIS == "FATS011299") %>% 
        filter(UNITS == "PCT_M-M")

data.fat <- data.fat[!duplicated(data.fat$SAMPLE_NUMBER),]

# Remove fat results that do not have a density --------------------------
data.all <- data.fat %>%
        filter(SAMPLE_NUMBER %in% data.density$SAMPLE_NUMBER)

# Combine ands simplify --------------------------------------------------
data.all2 <- rbind(data.all, data.density)

data.in_3 <- data.all2[, c(1,5,8)]
#data.in_3 <- data.all2[, c(1,4,7)]

data.in_4 <- spread(data.in_3, ANALYSIS, ENTRY)

data.in_5 <- data.in_4 %>% 
        filter(DENS030112 > 0.975)

# Graph ------------------------------------------------------------------

fat_dens_plot <- ggplot() +
        geom_point(data = data.in_4, aes(x=DENS030112, y=FATS011299),size=4, shape=21, fill = "red")+
        geom_point(data = data.in_5, aes(x=DENS030112, y=FATS011299),size=4, shape=21, fill = "cornflowerblue")+
        theme_bw()+
        theme(panel.grid.major = element_line(size = 0.5, color = "grey"), 
                axis.line = element_line(size = 0.7, color = "black"), 
                text = element_text(size = 14), axis.text.x = element_text(angle = 0, hjust = 1))
                
                        
fat_dens_plot

# ggsave("cream.png", width = 10, height = 10, dpi = 100)
