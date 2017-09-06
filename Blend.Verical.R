# Nominiate 3 milks to blend
# A = Whole Milk,   a = level of analyte present
# B = Skimmed Milk,      b = level of analyte present
# C = Water,   c = level of analyte present

library(dplyr)

A <- seq(0, 1, 0.05)
B <- seq(0, 1, 0.05)
C <- seq(0, 1, 0.05)


### Fat ---------------------------------------------------------------------------

a.f <- 1.3
b.f <- 10
c.f <- 1.4
target.f <- 5.65
delta.f <- 0.1

### True Protein ------------------------------------------------------------------

a.p <- 3.2
b.p <- 2.92
c.p <- 5.5
target.p <- 3.61
delta.p <- 0.1

### Lactose -----------------------------------------------------------------------

a.l <- 5.0
b.l <- 4.8
c.l <- 5.1
target.l <- 5.78
delta.l <- 0.05


### Component Calculations --------------------------------------------------------


Ap <- A*a.p
Bp <- B*b.p
Cp <- C*c.p

Af <- A*a.f
Bf <- B*b.f
Cf <- C*c.f

Al <- A*a.l
Bl <- B*b.l
Cl <- C*c.l

### Create the dataframe shell --------------------------------------------------------

Composite <- data.frame(
        TotP = numeric(),
        TotF = numeric(),
        TotL = numeric(),
        A = numeric(),
        B = numeric(),
        C = numeric())

### Combinations -------------------------------------------------------------------

i <- 1
j <- 1
k <- 1 
n <- 1

for (k in 1:21) {
        for (j in 1:21) {
                for (i in 1:21) {
                        
                Composite[n,1] = Ap[i] + Bp[j] + Cp[k]
                Composite[n,2] = Af[i] + Bf[j] + Cf[k]
                Composite[n,3] = Al[i] + Bl[j] + Cl[k]
                Composite[n,4] = A[i]
                Composite[n,5] = B[j]
                Composite[n,6] = C[k]
                n = n + 1
                }
        }
}

### Filtering for criteria --------------------------------------------------------

Composite <- select(Composite, everything()) %>%
      filter((A+B+C)==1)%>%
      filter(TotP < target.p+delta.p)%>%
      filter(TotP > target.p-delta.p)%>%
      filter(TotF < target.f+delta.f)%>%
      filter(TotF > target.f-delta.f)

Composite <- Composite[,c(2,1,3:6)]

Composite

write.csv(Composite, file="mix.csv", row.names=FALSE)
