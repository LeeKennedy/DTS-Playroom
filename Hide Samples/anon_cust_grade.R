#### Clean Up environment -----------------------------
rm(list=ls())

#### Packages -----------------------------
library(readxl)
library(tidyverse)
library(here)


#### Functions -----------------------------

anon_client_grade <- function(a,b){
        A1 <- LETTERS
        A2 <- LETTERS
        
        label_list <- expand.grid(A2, A1)
        label_list$n <- as.numeric(rownames(label_list))
        label_list$ID <- paste(label_list$Var2, label_list$Var1, sep="")
        label_list <- label_list[,c(3,4)]
        
        a <- a %>% 
                mutate(cust_id = group_indices(., CUSTOMER), 
                       grade_id = group_indices(., PRODUCT_GRADE)) 
        
        a$prime_ID <- paste(a$CUSTOMER, a$PRODUCT_GRADE, sep = "_")
        
        a <- merge(a, label_list, by.x = "cust_id", by.y = "n", all.x = TRUE)
        colnames(a)[23] <- "Cust_Code"
        
        a <- merge(a, label_list, by.x = "grade_id", by.y = "n", all.x = TRUE)
        colnames(a)[24] <- "Grade_Code"
        
        a$ID <- paste(a$Cust_Code, a$Grade_Code, sep = "")
        a <- a[,c(3:22,25)]
        
        j <- nrow(a)
        
        for(i in 1:j){
                if(a$CUSTOMER[i] %in% b == TRUE)
                        a$ID[i] <- a$prime_ID[i]
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
#### Function will take the CUSTOMER list and PRODUCT_GRADE list and remove the identity of all clients information
#### other than those in the target customer list.


temp <- anon_client_grade(data, target_customers)
