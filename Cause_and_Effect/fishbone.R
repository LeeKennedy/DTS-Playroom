library(qcc)
data=read.csv("fishbone.csv", as.is=TRUE, header=TRUE)
Effect=data$Effect[1]
cause.and.effect(data[,3:8],Effect, title = data$Title[1])

