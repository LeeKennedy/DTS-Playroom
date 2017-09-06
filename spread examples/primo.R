library(tidyr)
library(readxl)
library(dplyr)

data.in <- read_excel("PMBROAD.xlsx", sheet=1)
data1 <- data.in[, c(13,8)]

data2 <- data1 %>% group_by(PRODUCT_GRADE) %>% mutate(Item = seq_along(PRODUCT_GRADE))
wide_data <- spread(data2, PRODUCT_GRADE, ENTRY, fill = "")
wide_data 
