fcdata12 <- read.csv("FC12.csv", header=TRUE)
fcdata12$diff <- fcdata12$FC-fcdata12$Sys3
fcdata17 <- read.csv("FC17.csv", header=TRUE)
fcdata17$diff <- fcdata17$FC-fcdata17$Sys3
fcdata21 <- read.csv("FC21.csv", header=TRUE)
fcdata21$diff <- fcdata21$FC-fcdata21$Sys3

boxplot(fcdata12$diff, fcdata17$diff, fcdata21$diff)
abline(h = 0, col = "red", lty=2)

t.test(fcdata12$Sys3, fcdata12$FC, mu=0, conf=0.95)
t.test(fcdata17$Sys3, fcdata17$FC, mu=0, conf=0.95)
t.test(fcdata21$Sys3, fcdata21$FC, mu=0, conf=0.95)