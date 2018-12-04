# Clean Up environment ---------------------------------------------------
rm(list=ls())

# Packages ---------------------------------------------------------------
library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

# Data Input -------------------------------------------------------------
data.in <- read_excel("C:/Users/leekennedy/Desktop/Butter.xlsx", 
                      col_types = c("numeric", "date", "date", 
                                    "text", "text", "text", "text", "numeric", 
                                    "numeric", "text", "text", "text", 
                                    "text", "text", "text", "text", "text", 
                                    "text", "text"))

## Data Cleaning ---------------------------------------------------------

set <- unique(data.in$ANALYSIS)

boxplot(data.in$ENTRY~data.in$ANALYSIS)

data.in <- data.in %>% 
        filter(ANALYSIS == "MOIS070493" | ANALYSIS == "MOIS211099") %>% 
        filter(REPORTED_NAME == "Moisture") %>% 
        filter(ENTRY < 20)

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

data.in_3 <- data.all.comb[, c(1,5,8)]

data.in_4 <- spread(data.in_3, ANALYSIS, ENTRY)
colnames(data.in_4)[2] <- "B"
colnames(data.in_4)[3] <- "A"

fit <- lm(A~B-1, data=data.in_4)
summary(fit)
confint(fit)


# Graph ------------------------------------------------------------------

comparison_plot <- ggplot(data.in_4, aes(x=B, y=A)) +
                        geom_point(size=4, shape=21, col = "darkgreen", fill = "beige") +
        labs(x=set[1], y=set[2]) +
        geom_abline(slope = 1.0093959, intercept = 0.0005655, lty=2, col="red")+
        geom_abline(slope = 1, intercept = 0, lty=2, col="darkgreen")+
        theme_bw()
                        
comparison_plot
