#### Clean Up environment -----------------------------
rm(list=ls())

#### Packages -----------------------------
library(readxl)
library(tidyverse)
library(here)


#### Functions -----------------------------

anonymous <- function(a,b) {
        A1 <- LETTERS
        A2 <- LETTERS
        
        label_cust <- expand.grid(A2, A1)
        label_cust$n <- as.numeric(rownames(label_cust))
        label_cust$ID <- paste(label_cust$Var2, label_cust$Var1, sep="")
        label_cust <- label_cust[,c(3,4)]
        
        #### Data Working -----------------------------
        
        a <- a %>% 
                mutate(ID2 = group_indices(., CUSTOMER)) 
        
        a <- merge(a, label_cust, by.x = "ID2", by.y = "n", all.x = TRUE)
        a <- a[,-1]
        
        j <- nrow(data)
        
        for(i in 1:j){
                if(a$CUSTOMER[i] %in% b == TRUE)
                        a$ID[i] <- a$CUSTOMER[i]
                
        }   
        return (a)
}

#### Data Input -----------------------------

here()

data <- read_excel("Anonymous Samples/PVAL05.xlsx", 
                   col_types = c("numeric", "date", "date", 
                                 "text", "text", "text", "text", "numeric", 
                                 "text", "text", "text", "text", "text", 
                                 "text", "text", "text", "text", "text", 
                                 "numeric"))

target_customers <- as.list(c("MG80", "MG70"))

#### Run function --------------------------
#### Function will take the CUSTOMER list and remove the identity of all clients 
#### other than those in the target customer list.

temp <- anonymous(data, target_customers)
