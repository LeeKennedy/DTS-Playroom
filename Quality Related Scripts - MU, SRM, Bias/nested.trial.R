
target <- 1000
sdr <- 20
delta <- 20

targetlist <- rnorm(8, target, delta)

data1 <- list(A = rnorm(7, targetlist[1], sdr), 
              B = rnorm(3, targetlist[2], sdr),
              C = rnorm(3, targetlist[3], sdr),
              D = rnorm(3, targetlist[4], sdr),
              E = rnorm(3, targetlist[5], sdr),
              F = rnorm(3, targetlist[6], sdr),
              G = rnorm(3, targetlist[7], sdr),
              H = rnorm(0, targetlist[8], sdr))


dataset <- data.frame(
      lNames = rep(names(data1), lapply(data1, length)),
      lVal = unlist(data1))

boxplot(dataset$lVal~dataset$lNames)

# Run ANOVA
anova1 <- aov(lVal ~ lNames, data = dataset)

#Review results
summary(anova1)

#Check for significant differences
TukeyHSD(anova1)

#Repeatability & Interim Precision
mean.sqr <- summary(anova1)[1][[1]][[3]]
ncount <- as.numeric(length(anova1$effects))/as.numeric(length(anova1$coefficients))
sdr <- sqrt(mean.sqr[2])
interim <- sqrt((mean.sqr[1]-mean.sqr[2])/ncount)
sdR <- sqrt(sdr^2 + interim^2)
sdr
sdR
