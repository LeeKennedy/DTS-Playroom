data.in <- read.csv("Burra-Prot.csv", as.is=TRUE, header=TRUE)

# Some quick plots to check data

boxplot(data.in)
plot(data.in)
abline(a=0, b=1)

t.test(data.in$Chem, data.in$MAS, paired = TRUE)

