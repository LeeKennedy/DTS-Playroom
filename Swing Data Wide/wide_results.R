#### Clean Up environment -----------------------------
rm(list=ls())
 
#### Packages -----------------------------
library(readxl)
library(tidyverse)
library(dts.quality)
 
#### Functions -----------------------------
 
 
#### Data Input - xlsx preferred -----------------------------------------

## Preferred fields: "SAMPLE_NUMBER", "ANALYSIS", "REPORTED_NAME", "UNITS", "ENTRY", "REPLICATE_COUNT", "STATUS"
 
data.in <- read_excel("~/Desktop/Test1.xlsx", 
                      col_types = c("numeric", "date", "text", 
                                    "text", "text", "text", "numeric", 
                                    "text", "numeric"))

#### Data Cleaning -----------------------------

## Select only the reportable components--------

if("REPORTABLE" %in% names(data.in) == FALSE) {
        data.in$REPORTABLE = "T"
}

data.in2 <- data.in %>% filter(REPORTABLE == "T")

## Standardise UNITS ---------------------------
names(data.in2)[names(data.in2) == 'REPORTED_UNITS'] <- 'UNITS'

## If you want to compare specific results, eg FAME---------------------
#data.in2 <- data.in %>% filter(grepl("FAME", ANALYSIS))

## add dummy data if REPLICATE_COUNT and STATUS absent -----------------

if("STATUS" %in% names(data.in2) == FALSE) {
        data.in2$STATUS = "xxx"
}

if("REPLICATE_COUNT" %in% names(data.in2) == FALSE) {
        data.in2$REPLICATE_COUNT = 99
}

data.in2 <- data.in2[,c("SAMPLE_NUMBER", "ANALYSIS", "REPORTED_NAME", "UNITS", "ENTRY", "REPLICATE_COUNT", "STATUS")]
 
wide_data <- spread(data.in2, SAMPLE_NUMBER, ENTRY, fill="")

write.csv(wide_data, "summary.csv")
