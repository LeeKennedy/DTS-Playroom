df <- data.frame(Sample = c(1,1,1,2,2,2,3,3,3), Test = c("a","b","c","a","b","c","a","b","c"), Result = c(1,2,3,4,5,6,7,8,9))
df
library(tidyr)

df2 <- spread(df, Test, Result)
df2


