data1 <- read.csv("VITA11-12.csv", as.is = TRUE, header = TRUE)
library("ggplot2")

mean11 <- tapply(data1$ENTRY, data1$ANALYSIS, mean)

col1 <- "#CC3300"
col2 <- "#009900"

ggplot(data1, aes(x = SAMPLE_NUMBER, y = ENTRY, colour = ANALYSIS)) +
  geom_point(size = 3) + 
  stat_smooth(method = loess, se = TRUE, lwd=1) +
  scale_colour_manual(values = c(col1, col2)) +
  geom_hline(yintercept = mean11[[1]], colour=col1, lwd = 0.75, linetype=2) +
  geom_hline(yintercept = mean11[[2]], colour=col2, lwd = 0.75,linetype=2)

