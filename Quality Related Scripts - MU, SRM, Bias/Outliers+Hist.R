# Select data entry path, change name if necessary.
#x <- read.delim('clipboard', as.is=TRUE, header = FALSE)
x <- read.delim(pipe('pbpaste')) 
#x <- read.csv("vitd01.csv", header = TRUE)
xx <- sapply(x, as.numeric)
library(ggplot2)

remove_outliers <- function(x, na.rm = TRUE, ...) {
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}

par(mfrow = c(2,2))

qqnorm(xx)
qqline(xx, col = 2)

yy <- remove_outliers(xx)
qqnorm(yy)
qqline(yy, col = 2)

ww <- remove_outliers(yy)
qqnorm(ww)
qqline(ww, col = 2)

zz <- remove_outliers(ww)
qqnorm(zz)
qqline(zz, col = 2)

par(mfrow=c(1,1))

diff.out <- data.frame(xx, yy, ww, zz)
boxplot(diff.out)

zz
summary (zz)

rnge <- max(zz, na.rm = TRUE)-min(zz, na.rm =TRUE)
binsz <- rnge/25

rzz <- max(zz)

DF <- data.frame(rbind(xx,zz))

DF <- rbind(data.frame(dataset="Omitted", V1=xx),
            data.frame(dataset="Retained", V1=zz))
DF$dataset <- as.factor(DF$dataset)
colnames(DF)[2] <- "V1"

ggplot(DF, aes(x=V1, fill=dataset)) +
  geom_histogram(binwidth=binsz, colour="black", position="identity") +
  scale_fill_manual(breaks=1:2, values=c("lightgoldenrod1","grey"))

# Normality --------------------------------------------------------------

shapiro.test(DF$V1)