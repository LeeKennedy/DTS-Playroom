library(ggplot2)
library(dplyr)

all.srm <- read.csv("allData.csv", as.is=TRUE, header=TRUE)
all.srm$Calculated.Fibre <- as.numeric(as.character(all.srm$Calculated.Fibre))
all.srm <- all.srm %>%
        mutate(Calculated.Fibre = 100*Calculated.Fibre)


plot <-ggplot(all.srm, aes(x=Batch, y=Calculated.Fibre)) + 
        geom_point(size=4, colour = "darkgreen") +
        labs(x="Verical Composition", 
             y=paste("%"), 
             title= paste("Dietary Fibre")) +
        ylim(14, 19) +
        theme_bw() +
        theme(panel.grid.major = element_line(size = 0.5, color = "grey"), 
              axis.line = element_line(size = 0.7, color = "black"), 
              text = element_text(size = 14))
plot


png(filename = paste0("DF-2015.png", sep=""),
    width = 1000, height = 550, units = "px", pointsize = 12)
plot(plot)
dev.off()


all.srm$Protein.titre <- as.numeric(as.character(all.srm$Protein.titre))
plot1 <-ggplot(all.srm, aes(x=Batch, y=Protein.titre)) +
        geom_point(size=4, colour = "darkgreen") +
        labs(x="-", 
             y=paste("mL"), 
             title= paste("Protein Titre")) +
        ylim(2, 7) +
        theme_bw() +
        theme(panel.grid.major = element_line(size = 0.5, color = "grey"), 
              axis.line = element_line(size = 0.7, color = "black"), 
              legend.position = c(2.3,8), 
              text = element_text(size = 14))
plot1
png(filename = paste0("Protein_Titre-2015.png", sep=""),
    width = 1000, height = 550, units = "px", pointsize = 12)
plot(plot1)
dev.off()


all.srm$Residue.Weight <- as.numeric(as.character(all.srm$Residue.Weight))
plot2 <-ggplot(all.srm, aes(x=Batch, y=Residue.Weight)) +
        geom_point(size=4, colour = "darkgreen") +
        geom_smooth(aes(group=1),method = loess) +
        labs(x="-", 
             y=paste("mg"), 
             title= paste("Residue Weight")) +
        theme_bw() +
        theme(panel.grid.major = element_line(size = 0.5, color = "grey"), 
              axis.line = element_line(size = 0.7, color = "black"), 
              legend.position = c(2.3,8), 
              text = element_text(size = 14))
plot2
png(filename = paste0("Residue-2015.png", sep=""),
    width = 1000, height = 550, units = "px", pointsize = 12)
plot(plot2)
dev.off()



all.srm$Ash.calc <- as.numeric(as.character(all.srm$Ash.calc))
plot3 <-ggplot(all.srm, aes(x=Batch, y=Ash.calc)) +
        geom_point(size=4, colour = "darkgreen") +
        labs(x="-", 
             y=paste("mg"), 
             title= paste("Ash")) +
        theme_bw() +
        theme(panel.grid.major = element_line(size = 0.5, color = "grey"), 
              axis.line = element_line(size = 0.7, color = "black"), 
              legend.position = c(2.3,8), 
              text = element_text(size = 14))
plot3
png(filename = paste0("Ash-2015.png", sep=""),
    width = 1000, height = 550, units = "px", pointsize = 12)
plot(plot3)
dev.off()
