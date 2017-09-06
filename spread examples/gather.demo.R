library(tidyr)

data.in <- read.csv("Book1.csv", as.is=TRUE, header = TRUE)
data2 <-gather(data=data.in,key=Group,value=Result,na.rm=FALSE,A,B,C)
data2
