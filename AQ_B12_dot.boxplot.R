# Clean up -
rm(list=ls())

# packages ------
library(ggplot2)
library(dplyr)

# Data in --------
data.in <- read_excel("~/Desktop/AQ B12 Validation Workbook 2.xlsx", 
                      sheet = "ANOVA")
data.in <- sapply(data.in[1:6, 1:2], as.numeric)
data.in <- as.data.frame(data.in)

data.in2 <- na.omit(stack(data.in))

data.in2 <- data.in2[,c(2,1)]


plot_mean <- data.in2 %>% group_by(ind) %>% summarise(Mean=mean(values))

ggp <- ggplot() +
        geom_boxplot(data = data.in2, mapping = aes(x=ind, y=values), colour="grey50") +
        geom_point(data = data.in2, 
                   mapping = aes(x=ind, y=values), 
                   colour="darkblue", 
                   fill = "cornflowerblue", 
                   shape = 21,
                   size = 5) + 
        geom_line(data = plot_mean, mapping = aes(x=ind,y=Mean), colour="red", group=1) +
        theme_bw()
        

ggp


plot.design(values ~ ind, data = data.in2)
