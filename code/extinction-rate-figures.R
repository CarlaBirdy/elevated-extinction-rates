####################################################################################
#
# Graphing elevated modern-day extinction rate estimates for vertebrates and plants in Australia
#    By: Dr Carla Archibald
#    Description: This script graphs data on described species, describes extinctions, underlying 
#                 extinction rate,  elevated extinction rates.
#    Last edited: 17/12/2021
#     
####################################################################################

# wd, data & packages #####
# enable libraries
library(tidyverse)
library(stringr)
library(ggplot2)
library(viridis)

# set working directory and global variables
wd <- "N:/Planet-A/Current-Users/Carla-Archibald/Moden-day-extinction-rate/"

colourPalette3 <- c('#7FB685','#233D4D', '#FE7F2D')
colourPalette2 <- c('#FE7F2D','#233D4D')

# read in files
data_in <- read.csv(paste0(wd, "elevated-extinction-rates/data/extinction-rate-output-data.csv"))

#### Figure 1. Percentage (%) of taxonomic group extinct

# prepare data and graph extinction stats
extinction_stats_high <- data_in %>%
                          dplyr::filter(Background.extinction.estimate %in% c("High"))%>%
                          dplyr::mutate(Expected = (Expected.extinctions.between.1900.to.present/Described.species)*100)%>%
                          dplyr::mutate(Observed = (Documented.extinctions/Described.species)*100)%>%
                          dplyr::select(`Scale`, `Extinction.estimate`, `Taxonomic.group`, `Described.species`, Expected, Observed)%>%
                          tidyr::pivot_longer(cols =Expected:Observed, names_to = "Extinction_Type", values_to = "ExtinctionProportion")%>%
                          dplyr::mutate(ET_Scale = paste0(Extinction_Type, " ", Extinction.estimate))%>%
                          dplyr::filter(ET_Scale %in% c("Observed Highly Conservative","Observed Conservative","Expected Highly Conservative"))%>%
                          dplyr::mutate(ET_Scale = dplyr::recode(ET_Scale, 
                                                         "Expected Highly Conservative" = "a Expected",
                                                         "Observed Highly Conservative"= "b Observed",
                                                         "Observed Conservative"= "c Observed"))%>%
                          ggplot(.)+
                          geom_col(aes(x=Scale, y=ExtinctionProportion,fill=ET_Scale), position ="dodge")+
                          facet_wrap(~Taxonomic.group, scales="free", nrow =2)+
                          labs(x = "Taxonomic group",
                               y = "Percentage (%) of taxonomic group extinct",
                               fill = "Extinction type")+
                          scale_fill_manual(values = colourPalette3, labels = c("Expected", "Observed (Highly Conservative)", "Observed (Conservative)"))+
                          theme_bw()

extinction_stats_high
ggsave("extinction_stats_high.png") 

extinction_stats_low <- data_in %>%
                          dplyr::filter(Background.extinction.estimate %in% c("Low"))%>%
                          dplyr::mutate(Expected = (Expected.extinctions.between.1900.to.present/Described.species)*100)%>%
                          dplyr::mutate(Observed = (Documented.extinctions/Described.species)*100)%>%
                          dplyr::select(`Scale`, `Extinction.estimate`, `Taxonomic.group`, `Described.species`, Expected, Observed)%>%
                          tidyr::pivot_longer(cols =Expected:Observed, names_to = "Extinction_Type", values_to = "ExtinctionProportion")%>%
                          dplyr::mutate(ET_Scale = paste0(Extinction_Type, " ", Extinction.estimate))%>%
                          dplyr::filter(ET_Scale %in% c("Observed Highly Conservative","Observed Conservative","Expected Highly Conservative"))%>%
                          dplyr::mutate(ET_Scale = dplyr::recode(ET_Scale, 
                                                                 "Expected Highly Conservative" = "a Expected",
                                                                 "Observed Highly Conservative"= "b Observed",
                                                                 "Observed Conservative"= "c Observed"))%>%
                          ggplot(.)+
                          geom_col(aes(x=Scale, y=ExtinctionProportion,fill=ET_Scale), position ="dodge")+
                          facet_wrap(~Taxonomic.group, scales="free", nrow =2)+
                          labs(x = "Taxonomic group",
                               y = "Percentage (%) of taxonomic group extinct",
                               fill = "Extinction type")+
                          scale_fill_manual(values = colourPalette3, labels = c("Expected", "Observed (Highly Conservative)", "Observed (Conservative)"))+
                          theme_bw()

extinction_stats_low
ggsave("extinction_stats_low.png") 

#### Figure 2. Rates of modern extinction in terrestrial vertebrates and vascular plants compared to global estimates

# prepare data and graphing extinction rates
extinction_rates_high <- data_in %>%
                          dplyr::filter(Background.extinction.estimate %in% c("High"))%>%
                          dplyr::select(Scale, Taxonomic.group, Extinction.estimate, Elevated.extinction.rate.with.respect.to.expected) %>%
                          ggplot(.)+
                            geom_col(aes(x=reorder(Taxonomic.group, -Elevated.extinction.rate.with.respect.to.expected), y=Elevated.extinction.rate.with.respect.to.expected,fill=`Scale`), position ="dodge")+
                            labs(x = "Taxonomic group",
                                 y = "Moden-day extinction rate (E/MSY)")+
                            scale_fill_manual(values = colourPalette2)+
                            facet_wrap(~Extinction.estimate)+
                            theme_bw()+
                            theme(legend.title = element_blank(),
                                  legend.position=c(.85,.9))+
                            geom_hline(yintercept = 1, color="black", linetype="dashed", size =1.5)

extinction_rates_high
ggsave("extinction_rates_high.png") 

extinction_rates_low <- data_in %>%
                          dplyr::filter(Background.extinction.estimate %in% c("Low"))%>%
                          dplyr::select(Scale, Taxonomic.group, Extinction.estimate, Elevated.extinction.rate.with.respect.to.expected) %>%
                          ggplot(.)+
                            geom_col(aes(x=reorder(Taxonomic.group, -Elevated.extinction.rate.with.respect.to.expected), y=Elevated.extinction.rate.with.respect.to.expected,fill=`Scale`), position ="dodge")+
                            labs(x = "Taxonomic group",
                                 y = "Moden-day extinction rate (E/MSY)")+
                            scale_fill_manual(values = colourPalette2)+
                            facet_wrap(~Extinction.estimate)+
                            theme_bw()+
                            theme(legend.title = element_blank(),
                                  legend.position=c(.85,.9))+
                            geom_hline(yintercept = 1, color="black", linetype="dashed", size =1.5)

extinction_rates_low
ggsave("extinction_rates_low.png") 

# END :)