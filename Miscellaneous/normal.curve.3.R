library(ggplot2)
library(tidyr)



mn1 <- 170
n1 <-1
sd1 <- 10/sqrt(n1)

mn2 <- 170
n2 <- 2
sd2 <- 10/sqrt(n2)

delta <- mn2-mn1

x <- seq(from = 100, to = 210, by = 0.5)
y1 <- dnorm(x, mean = mn2, sd = sd2)
y2 <- dnorm(x, mean = mn1, sd = sd1)

h0 <- mn1+2*sd1

data1 <- as.data.frame(y1)
data2 <- as.data.frame(y2)
data1 <- cbind(x, data1, data2)

data3 <- gather(data1, c, x)
colnames(data3)[3] <- "z"

result <- data.frame(x1 = 130, y1=0.002)
result2 <- data.frame(x1 = c(145,152), y1=c(0.002, 0.002))

plot1 <- ggplot(data3, aes(x = x, y = z, col = c)) +
        geom_line(size = 1) +
        geom_vline(xintercept = 170, size = 1, lty = 2, colour = "orangered3") +
        #geom_vline(xintercept = 152, size = 1, lty = 2, colour = "orangered3") +
        #annotate("text", x = 140, y = 0.03, label = "3.3 x sd") +
        scale_color_brewer(palette="Set1", guide = FALSE) +
        scale_x_continuous(limits = c(100, 210)) +
        scale_y_continuous(limits = c(0, 0.06)) +
        theme_bw() 

#plot1 <- plot1 + 
#        geom_point(data=result,aes(x1,y1),colour="darkgreen",size=4) + 
 #       geom_point(data=result2,aes(x1,y1),colour="red",size=4)
plot1
        




ggsave("bias3.eps", width = 7, height = 4, units = "in")
