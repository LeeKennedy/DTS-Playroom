library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)

data <- read_csv("MU_2015.csv")

data2 <- data #%>%
        #filter(Type == "Interim Precision")

plot <- ggplot(data2, aes(x=log_mean, y=log_sd, colour = Type)) +
        geom_point(size=4, alpha=0.5) +
        #geom_smooth(method=glm) +
        scale_color_brewer(palette="Set1")
plot
