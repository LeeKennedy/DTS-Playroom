# Data

x1 <- 6.78
s1 <- 1.43
n1 <- 50

x2 <- 7.18
s2 <- 1.6
n2 <- 100

Diff <- x2-x1

SEdiff <- sqrt((s2^2/n2)+(s1^2/n1))

CI.lower <- Diff-1.96*SEdiff
CI.upper <- Diff+1.96*SEdiff

# Null Hypothesis
Ho <- 0

z <- (Diff - Ho)/SEdiff

# One tail
1-pnorm(z)

# Two tail
2*(1-pnorm(z))

# t value
t1 <- qt(0.975,n1-1)


library(ggplot2)
ggplot(data.frame(x = c(-2, 2)), aes(x)) + 
  stat_function(fun = dnorm, args = list(mean = 0, sd = SEdiff)) +
  geom_vline(xintercept=Diff, lty=2, col = "red")
