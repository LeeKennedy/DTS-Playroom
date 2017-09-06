#Reference mean
xref <- 0

# Read data
xx <- read.csv("AllMoist.csv", as.is=TRUE, header=TRUE)
xx$Diff <- xx$A - xx$B
xbar <- mean(xx$Diff)
xsd <- sd(xx$Diff)

#Plot graph
fxx <- function(x) dnorm(x, mean = xbar, sd = xsd)
myYLim <- c(0, 2)
plot(fxx, from = xbar-4*xsd, to = xbar+4*xsd, ylim = myYLim, col = "red", lwd = 3, xlab = "", ylab = "")

#Reference point
abline(v = xref, lwd = 3)
t.test(xx$Diff, mu=xref, alternative = "two.sided", paired = FALSE)


