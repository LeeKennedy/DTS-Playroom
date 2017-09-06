data.in <- read.csv("vitamind.csv", header=TRUE)
library(dplyr)

data.in <- data.in[1:15,]

t1 <- data.in$A
t2 <- data.in$B


boxplot(t1, t2)
summary(data.in)

t.test(t2, t1, paired = TRUE)


