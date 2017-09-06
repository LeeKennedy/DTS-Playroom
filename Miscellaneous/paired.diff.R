# Data for comparing two paired data sets
n <- 73
xdiff.bar <- 12.76
sd.diff <- 14.26

SEdiff <- sd.diff/sqrt(n)

# Ho is the proposed null difference.

Ho <- 0
z <- (xdiff.bar-Ho)/SEdiff

# Two sided
2*(1-pnorm(z))

# t value
t1 <- qt(0.975,n-1)

CI.lower <- xdiff.bar-1.96*SEdiff
CI.upper <- xdiff.bar+1.96*SEdiff
CI.lower.t <- xdiff.bar-t1*SEdiff
CI.upper.t <- xdiff.bar+t1*SEdiff

library(ggplot2)
ggplot(data.frame(x = c(-20, 20)), aes(x)) + 
  stat_function(fun = dnorm, args = list(mean = 0, sd = SEdiff)) +
  geom_vline(xintercept=xdiff.bar, lty=2, col = "red")
