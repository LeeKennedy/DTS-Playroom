# Input data
weights = read.table("weight.txt")

#Structure
str(weights)

#To make the data usable
library("lubridate")

#Basic plot
with(weights, plot(V2 ~ mdy(V1), 
                   xlim = c(mdy("1/1/14"),mdy("6/30/14")),
                   ylab="Weight", xlab="Date"))

#Average line function
lag = function(x,k) {
  return( c(rep(NA,k), x[1:(length(x)-k)]) )
}

#Creates a matrix of four off-set data columns and then average each line.
y = weights$V2
ra = rowMeans(
  matrix(c(y,lag(y,1),lag(y,2),lag(y,3)),ncol=4,byrow=F),
  na.rm=T)

#Line
lines(mdy(weights$V1),ra)