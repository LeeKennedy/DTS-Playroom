#### Clean Up environment -----------------------------
rm(list=ls())

#### Packages -----------------------------
library(readxl)
library(tidyverse)
library(here)


#### Functions -----------------------------


#### Data Input -----------------------------
here()

data <- read_excel("Anonymous Samples/PVAL05.xlsx", 
                   col_types = c("numeric", "date", "date", 
                                 "text", "text", "text", "text", "numeric", 
                                 "text", "text", "text", "text", "text", 
                                 "text", "text", "text", "text", "text", 
                                 "numeric"))

target_customers <- as.list(c("MG80", "MG70"))

A1 <- LETTERS
A2 <- LETTERS

label_cust <- expand.grid(A2, A1)
label_cust$n <- as.numeric(rownames(label_cust))
label_cust$ID <- paste(label_cust$Var2, label_cust$Var1, sep="")
label_cust <- label_cust[,c(3,4)]

#### Data Working -----------------------------

data <- data %>% 
        mutate(ID2 = group_indices(., CUSTOMER)) 

data <- merge(data, label_cust, by.x = "ID2", by.y = "n", all.x = TRUE)
data <- data[,-1]

j <- nrow(data)

for(i in 1:j){
        if(data$CUSTOMER[i] %in% target_customers == TRUE)
                data$ID[i] <- data$CUSTOMER[i]
}
