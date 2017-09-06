library(ggplot2)
data1 <- read.csv("Metals.csv", header = TRUE, stringsAsFactors = FALSE)
data1$Result <- as.numeric(data1$Result)

data2 <- data1[ which(data1$Analyte=='Sodium' & data1$Outlier=='No'), ]
data2$Control <- as.factor(data2$Control)
colnames(data2)[3] <- "Control2"

p <- ggplot(data2, aes(x = data2$Sample, y = data2$Result, color = data2$Method)) + geom_point( size=3, alpha = 1) 
p

p + facet_wrap(~Control2,ncol=1) # individual panels
