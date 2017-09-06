# Data file has 'n' & 'sd'.  Can have multiple reported names.
library(dplyr)
        
df <- read.csv("Trial3.csv", header = TRUE)


df2 <-  df %>%
      group_by(REPORTED_NAME)%>%
      mutate(n2 = n-1)%>%
      summarise(pool = sqrt(sum(sd^2*n2)/sum(n2)))
df2
