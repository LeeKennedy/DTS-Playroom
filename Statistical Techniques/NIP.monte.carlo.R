library(dplyr)
library(ggplot2)


#---- Set number of replicates -------------------------------------------  

n <- 10000

#---- Set compositional parameters (Mean & sd) ---------------------------

moisture_result <- 40
moisture_sd   <- 0.47

ash_result <- 4
ash_sd   <- 0.07

fat_result <- 10
fat_sd   <- 0.32

prot_result <- 8.0
prot_sd   <- 0.27

df_result <- 1.3
df_sd   <- 0.47

# --- Create random data -------------------------------------------------

MOIST <- rnorm(n, moisture_result, moisture_sd)
ASH <- rnorm(n, ash_result, ash_sd)
FAT <- rnorm(n, fat_result, fat_sd)
PROT <- rnorm(n, prot_result, prot_sd)
DF <- rnorm(n, df_result, df_sd)

# ---- Create dataframe --------------------------------------------------

nip <- as.data.frame(cbind(MOIST, ASH, FAT, PROT, DF))

# ---- Create CHO & kJ data ----------------------------------------------

nip <- nip %>%
        mutate(CHO = 100-MOIST-ASH-FAT-PROT-DF, 
               KJ = 37*FAT+17*(PROT + CHO)) 

# ---- Create CHO & kJ summary -------------------------------------------

cho_kj <- nip %>%
        summarise(CHO_mean = round(mean(CHO),2),
                  CHO_mu = round(2*sd(CHO),2),
                  KJ_mean = round(mean(KJ),0),
                  KJ_sd = round(2*sd(KJ),0))

# ---- Determine limits --------------------------------------------------

limits_CHO <- quantile(nip$CHO, c(0.025, 0.975))
limits_KJ <- quantile(nip$KJ, c(0.025, 0.975))

# ---- Plot Histograms ---------------------------------------------------

plot_CHO <- ggplot(nip, aes(x=CHO)) + 
        geom_histogram(binwidth = 0.2, colour = "darkgreen", fill = "burlywood1") +
        geom_vline(xintercept = limits_CHO[1], lty=2, colour = "red") +
        geom_vline(xintercept = limits_CHO[2], lty=2, colour = "red") +
        theme_bw()
plot_CHO

plot_KJ <- ggplot(nip, aes(x=KJ)) + 
        geom_histogram(binwidth = 2, colour = "darkgreen", fill = "burlywood1") +
        geom_vline(xintercept = limits_KJ[1], lty=2, colour = "red") +
        geom_vline(xintercept = limits_KJ[2], lty=2, colour = "red") +
        theme_bw()
plot_KJ

# ---- Print summary data ------------------------------------------------

cho_kj

