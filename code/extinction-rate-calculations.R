####################################################################################
#
# Elevated modern-day extinction rate estimates for vertebrates and plants in Australia
#    By: Dr Carla Archibald
#    Description: This script takes data on described species, describes extinctions and underlying 
#                 extinction rate and computes elevated extinction rates. To see methods followed see 
#                 Ceballos, G. et al. (2015) doi: 10.1126/sciadv.1400253.
#    Last edited: 17/12/2021
#     
####################################################################################

# wd, data & packages #####
# enable libraries
library(tidyr)
library(dplyr)
library(readr)

# set working directory
wd <- "N:/Planet-A/Current-Users/Carla-Archibald/Moden-day-extinction-rate/"

# read in files
data_in <- read.csv(paste0(wd, "elevated-extinction-rates/data/extinction-rate-input-data.csv"))
year <- 1900 # can also use 1500

# computes elevated extinction rates, as per Ceballos, G. et al. (2015)
data_out <- data_in %>%
              dplyr::mutate("Described.Species.divided.by.10000" = as.numeric(Described.species)/10000)%>% 
              dplyr::mutate("Centuries.Since.1900" = (2021-1900)/100)%>%  
              dplyr::mutate("Background.extinction.expected.since.1900" = Centuries.Since.1900*Background.extinction.per.century.expected.for.10.000.species)%>% 
              dplyr::mutate("Expected.extinctions.between.1900.to.present" = Described.Species.divided.by.10000*Background.extinction.expected.since.1900)%>% 
              dplyr::mutate("Elevated.extinction.rate.with.respect.to.expected" = Documented.extinctions/Expected.extinctions.between.1900.to.present)%>% 
              dplyr::mutate("Approximated.Modern-day.extinction.rate.E/MSY" = ((10000/Described.species)*Documented.extinctions)/Centuries.Since.1900) 
  
# write out files
write.csv(data_out, file=paste0(wd, "elevated-extinction-rates/data/extinction-rate-output-data.csv"),row.names=FALSE)
  
# END :)