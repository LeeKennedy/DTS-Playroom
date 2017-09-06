# Insert mean and std deviation into A, B & C.  Add other variables, as needed.
library(dplyr)

# Insert appropriate values --------------------------------------------------
Result_Mean1 <- 77
Result_sd_R1 <- 1.0
Result_Mean2 <- 77
Result_sd_R2 <- 1.0

# Set the data matrix --------------------------------------------------------
A <- rnorm(100000, Result_Mean1, Result_sd_R1)
B <- rnorm(100000, Result_Mean2, Result_sd_R2)


# Combine to create sets -----------------------------------------------------

Set <- as.data.frame(cbind(A,B))
Set$Diff <- A-B

# Calc means and sd for composite value --------------------------------------

Em <- mean(Set$Diff)
Esd <- sd(Set$Diff)
Lower = Em-2*Esd
Upper = Em+2*Esd
Range = 4*Esd

# Histogram of ranges --------------------------------------------------------
hist(Set$Diff, breaks=50)
abline(v=Upper, col="red", lty=2)
abline(v=Lower, col="red", lty=2)

Range
