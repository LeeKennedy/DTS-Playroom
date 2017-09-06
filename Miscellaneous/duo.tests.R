# Find samples that have both tests assigned to them ----------------------

# Clean ------------------------------------------------------------------
rm(list=ls())

# packages  --------------------------------------------------------------
library(readxl)
library(dplyr)
library(readr)


# Data in ----------------------------------------------------------------

data.in <- read_excel("C:/Users/leekennedy/Desktop/CHLNCARN.xlsx")
colnames(data.in)[1] <- "SAMPLE_NUMBER"
data.in <- data.in[,-18]

# Separate ---------------------------------------------------------------
carn <- data.in %>% 
        filter(ANALYSIS == "CARN010711") %>% 
        select(SAMPLE_NUMBER)

chln <- data.in %>% 
        filter(ANALYSIS == "CHLN010507")%>% 
        select(SAMPLE_NUMBER)

duo_x <- unique(merge(carn, chln))
