# Insert mean and std deviation into A, B & C.  Add other variables, as needed.
library(dplyr)

# Insert appropriate values --------------------------------------------------
Result_Mean <- 4.5
Result_sd_r <- 0.3
Result_sd_R <- 0.806

# Set the data matrix --------------------------------------------------------
A <- rnorm(100000, Result_Mean, Result_sd_R)
B <- rnorm(100000, Result_Mean, Result_sd_R)

B1 <- rnorm(100000, B, Result_sd_r)
B2 <- rnorm(100000, B, Result_sd_r)

# Combine to create sets -----------------------------------------------------

Set <- as.data.frame(cbind(A,B1,B2))

Range <- numeric(100000)
Range <-as.data.frame(t(apply(Set[,c(1:3)],1,range)))

Eqn <- Range %>%
        mutate(Diff = V2-V1)

# Calc means and sd for composite value --------------------------------------

Em <- mean(Eqn$Diff)
Esd <- sd(Eqn$Diff)
k <- 1.98
Range_max <- Em + k*Esd

# Histogram of ranges --------------------------------------------------------
hist(Eqn$Diff, breaks=30)

#Maximum range of results for a single test and two retests ------------------
Range_max