data.in <- read.csv("Book2.csv", header=TRUE)
library(dplyr)

# Determines the effect size between two sets of data.
cohens_d <- function(x, y) {
        lx <- length(x)- 1
        ly <- length(y)- 1
        md  <- abs(mean(x) - mean(y))
        csd <- lx * var(x) + ly * var(y)
        csd <- csd/(lx + ly)
        csd <- sqrt(csd)
        
        cd  <- md/csd   ## cohen's d
}

data.in <- data.in[1:15,]

t1 <- data.in$A
t2 <- data.in$B


boxplot(t1, t2)
summary(data.in)

t.test(t2, t1, paired = TRUE)

aa <- cohens_d(data.in$A, data.in$B)
round(aa,2)
