#### Clean Up environment -----------------------------
rm(list=ls())
 
#### Packages -----------------------------
library(readxl)
library(tidyverse)
library(dts.quality)
 
#### Functions -----------------------------
 
 
#### Data Input -----------------------------
 
data.in <- read_excel("~/Documents/GitHub/DTS Playroom/Swing Data Wide/TCAR_testdata.xlsx", 
                      col_types = c("numeric", "date", "date", 
                                    "text", "text", "text", "text", "numeric", 
                                    "numeric", "text", "text", "text", 
                                    "text", "text", "text", "text", "text", 
                                    "text", "text", "numeric"))
        
#### Data Cleaning -----------------------------
## Select only the reportable components--------

data.in2 <- data.in %>% filter(REPORTABLE == "T")

## If you want to compare unreportable results, eg FAME---------------------
#data.in2 <- data.in %>% filter(grepl("FAME", ANALYSIS))

data.in2 <- data.in2[,c("SAMPLE_NUMBER", "ANALYSIS", "REPORTED_NAME", "UNITS", "ENTRY", "REPLICATE_COUNT", "STATUS")]
 
wide_data <- spread(data.in2, SAMPLE_NUMBER, ENTRY, fill="")

write.csv(wide_data, "summary.csv")
