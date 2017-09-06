#### Clean Up environment -----------------------------
rm(list=ls())

#### Packages -----------------------------
library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(dts.quality)

#### Functions -----------------------------


#### Data Input -----------------------------

data.in <- read_excel("~/Desktop/FOLA04_2017.xlsx", 
                      col_types = c("numeric", "numeric", "text", 
                                    "text", "text", "text", "numeric", 
                                    "numeric", "text", "text", "text", 
                                    "text", "text", "text", "text", "text", 
                                    "text", "text", "numeric"))

#### Data Cleaning -----------------------------

data2 <- data.in[,c(1,5,7)]
data2 <- na.omit(data2)

data2a <- data2 %>% group_by(REPORTED_NAME) %>% mutate(Item = seq_along(REPORTED_NAME))

data2a <- as.data.frame(data2a[,c(1,4,2,3)])

data3 <- spread(data2a, REPORTED_NAME, ENTRY)

data4 <- data3 %>% 
        mutate(tolerance = 0.15*(`Raw Total Folate 1`+`Raw Total Folate 2`)/2) %>% 
        mutate(diff = abs(`Raw Total Folate 1`-`Raw Total Folate 2`) ) %>% 
        mutate(pct_diff = 100*diff/(tolerance/0.15)) %>% 
        mutate(test = (diff > tolerance))

#### Visualising Data -----------------------------

hist(data4$pct_diff, breaks = 30)
