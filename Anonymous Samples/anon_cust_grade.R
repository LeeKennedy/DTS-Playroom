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

#### Data Working -----------------------------

A1 <- LETTERS
A2 <- LETTERS

label_list <- expand.grid(A2, A1)
label_list$n <- as.numeric(rownames(label_list))
label_list$ID <- paste(label_list$Var2, label_list$Var1, sep="")
label_list <- label_list[,c(3,4)]

data <- data %>% 
        mutate(cust_id = group_indices(., CUSTOMER), 
               grade_id = group_indices(., PRODUCT_GRADE)) 

data$prime_ID <- paste(data$CUSTOMER, data$PRODUCT_GRADE, sep = "_")

data <- merge(data, label_list, by.x = "cust_id", by.y = "n", all.x = TRUE)
colnames(data)[23] <- "Cust_Code"

data <- merge(data, label_list, by.x = "grade_id", by.y = "n", all.x = TRUE)
colnames(data)[24] <- "Grade_Code"

data$ID <- paste(data$Cust_Code, data$Grade_Code, sep = "")
data <- data[,c(3:22,25)]

j <- nrow(data)

for(i in 1:j){
        if(data$CUSTOMER[i] %in% target_customers == TRUE)
                data$ID[i] <- data$prime_ID[i]
}
