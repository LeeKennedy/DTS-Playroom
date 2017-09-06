library(tidyr)
library(psych)

x <- 100   # Mean     
r <- 2  # Repeatability sd
R <- 5  # Reproducibility sd
i <- 9  # extra columns excluding column 1.  Max = 9
j <- 7  # items in first column. Max = 7
k <- 7  # items in remaining columns. Max = 7

nest_output <- data.frame(
        Repeatability = numeric(),
        Reproducibility = numeric(),
        Interim_Precision = numeric()
)

for (a in 1:10000) {
Seed <- rnorm((i+1), x, R)

A <- rnorm(7, mean = Seed[1], sd = r)
B <- rnorm(7, mean = Seed[2], sd = r)
C <- rnorm(7, mean = Seed[3], sd = r)
D <- rnorm(7, mean = Seed[4], sd = r)
E <- rnorm(7, mean = Seed[5], sd = r)
F <- rnorm(7, mean = Seed[6], sd = r)
G <- rnorm(7, mean = Seed[7], sd = r)
H <- rnorm(7, mean = Seed[8], sd = r)
I <- rnorm(7, mean = Seed[9], sd = r)
J <- rnorm(7, mean = Seed[10], sd = r)

df2 <- data.frame(A, B, C, D, E, F, G, H, I, J)
df2[df2=="NaN"] <- "NA"

for (l in (j+1):7) {
    df2[l,1] = NA    
}

for (m in 2:(1+i)) 
        for(n in (k+1):7) {
                df2[n,m] = NA
        }
df2

df3 <- stack(df2)
df3$values <- as.numeric(df3$values)
df3 <- na.omit(df3)
df3 <- df3[,c(2,1)]

# Run ANOVA
anova1 <- aov(values ~ ind, data = df3)

#Repeatability & Interim Precision
mean.sqr <- summary(anova1)[1][[1]][[3]]
ncount <- as.numeric(length(anova1$effects))/as.numeric(length(anova1$coefficients))
sdr <- sqrt(mean.sqr[2])
interim <- sqrt((mean.sqr[1]-mean.sqr[2])/ncount)
sdR <- sqrt(sdr^2 + interim^2)

nest_output[a,1] <- sdr
nest_output[a,2] <- sdR
nest_output[a,3] <- interim

}
describe(nest_output, skew = FALSE)
hist(nest_output[,2], breaks = 25)
