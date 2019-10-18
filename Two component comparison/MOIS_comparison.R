# Clean Up environment ---------------------------------------------------
rm(list=ls())

# Packages ---------------------------------------------------------------
library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(here)

# Data Input -------------------------------------------------------------
data.in <- read_excel("NOTAT2.xlsx")

## Data Cleaning ---------------------------------------------------------

# Remove duplicates ------------------------------------------------------

data.MOIS08 <- data.in %>%
        filter(ANALYSIS == "MOIS080693")
data.MOIS08 <- data.MOIS08[!duplicated(data.MOIS08$SAMPLE_NUMBER),]

data.MOIS16 <- data.in %>%
        filter(ANALYSIS == "MOIS161196") 
data.MOIS16 <- data.MOIS16[!duplicated(data.MOIS16$SAMPLE_NUMBER),]

# Remove fat results that do not have a density --------------------------
data.all <- data.MOIS16 %>%
        filter(SAMPLE_NUMBER %in% data.MOIS08$SAMPLE_NUMBER)

data.alla <- data.MOIS08 %>%
        filter(SAMPLE_NUMBER %in% data.all$SAMPLE_NUMBER)

# Combine ands simplify --------------------------------------------------
data.all2 <- rbind(data.all, data.alla)



data.in_3 <- data.all2[, c(1,3,5)]
#data.in_3 <- data.all2[, c(1,4,7)]

data.in_4 <- spread(data.in_3, ANALYSIS, ENTRY)
data.in_4 <- na.omit(data.in_4)

fit <- lm(data.in_4$MOIS161196~data.in_4$MOIS080693-1)
summary(fit)
confint(fit)

# Graph ------------------------------------------------------------------

moist_plot <- ggplot() +
        geom_point(data = data.in_4, aes(x=MOIS080693, y=MOIS161196 ),size=4, shape=21, fill = "cornflowerblue")+
        geom_abline(slope = 1, intercept = 0, lty=2, col = "red")+
        geom_abline(slope = 1.3829, intercept = 0, lty=2, col="grey50")+
        labs(title = "Comparison of Moisture Methods", caption = "Red line = 1:1 equivalence")+
        theme_bw()+
        theme(panel.grid.major = element_line(size = 0.5, color = "grey"), 
                axis.line = element_line(size = 0.7, color = "black"), 
                text = element_text(size = 14), axis.text.x = element_text(angle = 0, hjust = 1))
moist_plot

# ggsave("Moisture.png", width = 12, height = 8, dpi = 100)
