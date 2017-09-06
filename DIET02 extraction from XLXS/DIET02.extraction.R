library(xlsx)
library(dplyr)

all.srm <- data.frame(
        Sample = factor(),
        DTS.NO = factor(),
        Sample.mass = numeric(),
        Residue.Weight <- as.numeric(),
        Protein.titre <- as.numeric(),
        Ash.calc <- as.numeric(),
        Calculated.Fibre <- as.numeric())

code <- "DIET02"
test.year <- 15

#j <- c(1,2,3,5,6,7,9:13,15:17,19:23,25:30,32:35,37:46,48:51,53,55:60,62)
j <- c(101,102,104:107,109:112,114:120,122:123,125:132,134:136,138:143,145:146,148:151)

for (i in j) {
batch <-i
if(batch <10) {
        batch1 = paste("000",batch, sep="")
        }else{
                if(batch < 100) {
                        batch1 = paste("00",batch, sep="")
                }else{
                        batch1 = paste("0",batch, sep="")
                }
                }
        
filename <- paste(code,test.year,batch1, sep="-")

dat <- read.xlsx(paste(filename,"xls", sep="."), sheetName="Total", startRow=4)

srm <- dat %>%
        filter(DTS.NO == "55N")
srm$Batch <- paste(test.year,batch1,sep="-")
srm1 <- srm[, c(49,1,4,15,22,24,27,33)]


all.srm <- rbind(all.srm, srm1)
}
write.csv(all.srm, "allData.csv", row.names=FALSE)
