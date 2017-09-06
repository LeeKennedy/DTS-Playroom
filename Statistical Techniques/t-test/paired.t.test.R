t1 <- rnorm(50, mean = 52, sd = 6)
#to simulate change over time: a differnce variable
dif <- rnorm(50, mean = 6, sd = 12)
t2 <- t1 + dif
hist(t1)
hist(dif)
hist(t2)
boxplot(t1, t2)
pairs <- data.frame(t1, t2)
library(MASS)
parcoord(pairs, var.label = TRUE)
#On average, are the lines going up or down?
t.test(t2, t1, paired = TRUE)
t.test(t2, t1,
       paired = TRUE,
       mu = 6, #Specifying a non-0 null value (Remember we added a random variable, mean 6)
       alternative = "greater",
       conf.level = 0.99)