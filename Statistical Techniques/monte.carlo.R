# Insert mean and std deviation into A, B & C.  Add other variables, as needed.

A <- rnorm(100000, 80, 0.55)
B <- rnorm(100000, 15, 0.18)
C <- rnorm(100000, 1.033, 0.0002)

# Create an equation:

Eqn <- 100-A-B

# Calc means and sd for composite value:

Em <- mean(Eqn)
Esd <- sd(Eqn)
k <- 1.98
E.mu <- k*Esd

Em
Esd
k
E.mu

hist(Eqn, breaks=30)
