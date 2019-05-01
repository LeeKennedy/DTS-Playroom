#### Clean Up environment -----------------------------
rm(list=ls())

#### Packages -----------------------------
library(readxl)
library(tidyverse)
library(here)


#### Functions -----------------------------
outliers <- function (x, b = FALSE) {
xx <- sapply(x, as.numeric)

#xx <- sort(xx)

remove_outliers <- function(x, na.rm = TRUE, ...) {
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}

yy <- remove_outliers(xx)
ww <- remove_outliers(yy)
zz <- remove_outliers(ww)

diff.out <- data.frame(xx, yy, ww, zz)

if(b == TRUE){
boxplot(diff.out)
}

return(zz)
}

#### Data Input -----------------------------
here()

data <- read_excel("PVAL05.xlsx", col_types = c("numeric", 
                                                "date", "date", "text", "text", "text", 
                                                "text", "numeric", "text", "text", "text", 
                                                "text", "text", "text", "text", "text", 
                                                "text", "text", "numeric"))

target_customers <- as.list(c("MG80", "MG70"))

#### Data Working -----------------------------

data <- data %>% 
        mutate(cust_id = group_indices(., CUSTOMER), 
               grade_id = group_indices(., PRODUCT_GRADE),
               ID = paste(cust_id, grade_id, sep = "_"),
               prime_ID = paste(data$CUSTOMER, data$PRODUCT_GRADE, sep = "_")) 

j <- nrow(data)

for(i in 1:j){
        if(data$CUSTOMER[i] %in% target_customers == TRUE)
                data$ID[i] <- data$prime_ID[i]
}