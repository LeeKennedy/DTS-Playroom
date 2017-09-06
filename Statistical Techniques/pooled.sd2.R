#Data input as sets of raw data, with headers but rows unlabelled.

psd <- read.csv("pooledsd.csv", as.is=TRUE, header=TRUE)
library(reshape2)
library(dplyr)


psd <- na.omit(stack(psd))

psd1 <-  psd %>%
      group_by(ind)%>%
      summarise(mean = mean(values), sd = sd(values), n()-1)

colnames(psd1)[4] <- "df"

pooledSD <- sqrt( sum(psd1$sd^2 * psd1$df) / sum(psd1$df) )

psd1

paste("Pooled sd =", pooledSD)
