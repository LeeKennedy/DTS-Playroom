# Clean Up environment ---------------------------------------------------
rm(list=ls())

# Packages ---------------------------------------------------------------
library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

# Functions --------------------------------------------------------------

remove_outliers <- function(x, na.rm = TRUE, ...) {
 qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
 y <- x
 y[x < (qnt[1] - H)] <- NA
 y[x > (qnt[2] + H)] <- NA
 y
}

# Data Input -------------------------------------------------------------

data.in <- read_csv("Two_Samples.csv")

# Data Cleaning ----------------------------------------------------------

data.in <- data.in[,1:6]

sets <- unique(data.in$SAMPLE_NUMBER)

data_plot <- spread(data.in, SAMPLE_NUMBER, ENTRY)

A <- colnames(data_plot)[5]
B <- colnames(data_plot)[6]
colnames(data_plot)[5] <- "A"
colnames(data_plot)[6] <- "B"

# Visualising Data -------------------------------------------------------

plot_data <- ggplot(data_plot, aes(x=A, y=B)) +
        geom_point(size=4, shape=21, fill = "beige", colour = "darkgreen") +
        labs(x=A, y = B) +
        geom_abline(intercept = 0, slope = 1, col = "red", lty=2) +
        theme_bw()
plot_data

# Plot Ratio of data ----------------------------------------------------

data_plot <- data_plot %>% 
        mutate(Ratio = A*100/B)

ratio_plot <- ggplot(data_plot,aes(x=REPORTED_NAME, y = Ratio)) +
        geom_point(size = 5, shape = 21, fill = "beige", col = "darkgreen") +
        labs(x = "\nElement", title = paste("Ratio ",A," to ",B, sep="")) +
        theme_bw()
ratio_plot
