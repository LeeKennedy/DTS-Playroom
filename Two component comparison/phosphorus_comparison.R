# Clean Up environment ---------------------------------------------------
rm(list=ls())

# Packages ---------------------------------------------------------------
library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

# Data Input -------------------------------------------------------------
data.in <- read_excel("Phosphorus_02102019.xlsx")

## Data Cleaning ---------------------------------------------------------

# Remove duplicates ------------------------------------------------------

data.MICP01 <- data.in %>%
        filter(ANALYSIS == "MICP010406")
data.MICP01 <- data.MICP01[!duplicated(data.MICP01$SAMPLE_NUMBER),]

data.PHOS01 <- data.in %>%
        filter(ANALYSIS == "PHOS010493") 

data.PHOS01 <- data.PHOS01[!duplicated(data.PHOS01$SAMPLE_NUMBER),]

# Remove fat results that do not have a density --------------------------
data.all <- data.MICP01 %>%
        filter(SAMPLE_NUMBER %in% data.PHOS01$SAMPLE_NUMBER)

# Combine ands simplify --------------------------------------------------
data.all2 <- rbind(data.all, data.PHOS01)

data.all2$ENTRY[data.all2$REPORTED_UNITS == "PCT_M-M"] <- data.all2$ENTRY*1000

data.in_3 <- data.all2[, c(1,3,5)]
#data.in_3 <- data.all2[, c(1,4,7)]

data.in_4 <- spread(data.in_3, ANALYSIS, ENTRY)

fit <- lm(data.in_4$MICP010406~data.in_4$PHOS010493-1)
summary(fit)
confint(fit)

# Graph ------------------------------------------------------------------

phos_plot <- ggplot() +
        geom_point(data = data.in_4, aes(x=PHOS010493, y=MICP010406 ),size=4, shape=21, fill = "cornflowerblue")+
        geom_abline(slope = 1, intercept = 0, lty=2, col = "red")+
        #geom_abline(slope = 1.16887, intercept = 0, lty=1, col="grey70")+
        labs(title = "Comparison of Phosphorus Methods", x = "PHOS01, mg/100g", y = "MICP01, mg/100g", caption = "Red line = 1:1 equivalence")+
        theme_bw()+
        theme(panel.grid.major = element_line(size = 0.5, color = "grey"), 
                axis.line = element_line(size = 0.7, color = "black"), 
                text = element_text(size = 14), axis.text.x = element_text(angle = 0, hjust = 1))
phos_plot

# ggsave("Phosphorus.png", width = 12, height = 8, dpi = 100)
