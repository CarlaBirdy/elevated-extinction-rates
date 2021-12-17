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

# set working directory
wd <- "N:/Planet-A/Current-Users/Carla-Archibald/Moden-day-extinction-rate/"

# read in files
data_in <- read.csv(paste0(wd, "elevated-extinction-rates/data/extinction-rate-output-data.csv"))

#### Figure 1. Percentage (%) of taxonomic group extinct

# prepare data for graphing extinction stats
extinction_stats_high <- data_in %>%
                          dplyr::filter(Background.extinction.estimate %in% c("High"))%>%
                          dplyr::mutate(Expected = (Expected.extinctions.between.1990.to.present/Described.species)*100)%>%
                          dplyr::mutate(Observed = (Documented.extinctions/Described.species)*100)%>%
                          dplyr::select(`Scale`, `Extinction.estimate`, `Taxonomic.group`, `Described.species`, Expected, Observed)%>%
                          tidyr::pivot_longer(cols =Expected:Observed, names_to = "Extinction_Type", values_to = "ExtinctionProportion")%>%
                          dplyr::mutate(ET_Scale = paste0(Extinction_Type, " ", Extinction.estimate))%>%
                          dplyr::filter(ET_Scale %in% c("Observed Highly Conservative","Observed Conservative","Expected Highly Conservative"))%>%
                          dplyr::mutate(ET_Scale = dplyr::recode(ET_Scale, 
                                                         "Expected Highly Conservative" = "a Expected",
                                                         "Observed Highly Conservative"= "b Observed",
                                                         "Observed Conservative"= "c Observed"))
extinction_stats_low <- data_in %>%
                          dplyr::filter(Background.extinction.estimate %in% c("Low"))%>%
                          dplyr::mutate(Expected = (Expected.extinctions.between.1990.to.present/Described.species)*100)%>%
                          dplyr::mutate(Observed = (Documented.extinctions/Described.species)*100)%>%
                          dplyr::select(`Scale`, `Extinction.estimate`, `Taxonomic.group`, `Described.species`, Expected, Observed)%>%
                          tidyr::pivot_longer(cols =Expected:Observed, names_to = "Extinction_Type", values_to = "ExtinctionProportion")%>%
                          dplyr::mutate(ET_Scale = paste0(Extinction_Type, " ", Extinction.estimate))%>%
                          dplyr::filter(ET_Scale %in% c("Observed Highly Conservative","Observed Conservative","Expected Highly Conservative"))%>%
                          dplyr::mutate(ET_Scale = dplyr::recode(ET_Scale, 
                                                                 "Expected Highly Conservative" = "a Expected",
                                                                 "Observed Highly Conservative"= "b Observed",
                                                                 "Observed Conservative"= "c Observed"))

# graphing extinction stats

ggplot(extinction_stats_high)+
  geom_col(aes(x=Scale, y=ExtinctionProportion,fill=ET_Scale), position ="dodge")+
  facet_wrap(~Taxonomic.group, scales="free", nrow =2)+
  labs(x = "Taxonomic group",
       y = "Percentage (%) of taxonomic group extinct",
       fill = "Extinction type")+
  scale_fill_manual(values = carlaPallete, labels = c("Expected", "Observed (Highly Conservative)", "Observed (Conservative)"))+
  theme_bw()

ggplot(extinction_stats_low)+
  geom_col(aes(x=Scale, y=ExtinctionProportion,fill=ET_Scale), position ="dodge")+
  facet_wrap(~Taxonomic.group, scales="free", nrow =2)+
  labs(x = "Taxonomic group",
       y = "Percentage (%) of taxonomic group extinct",
       fill = "Extinction type")+
  scale_fill_manual(values = carlaPallete, labels = c("Expected", "Observed (Highly Conservative)", "Observed (Conservative)"))+
  theme_bw()

#### Figure 2. Rates of modern extinction in terrestrial vertebrates and vascular plants compared to global estimates

# prepare data for graphing extinction rates


extinctionsCsv_C <- data_in %>%
                      dplyr::mutate(Expected = (Expected.extinctions.between.1990.to.2021/Described.Species)*100)%>%
                      dplyr::mutate(Observed = (Documented.Extinctions/Described.Species)*100)%>%
                      dplyr::select(`Scale`, `Extinction.estimate`, `Group`, `Described.Species`, Expected, Observed)%>%
                      tidyr::pivot_longer(cols =Expected:Observed, names_to = "Extinction_Type", values_to = "ExtinctionProportion")%>%
                      dplyr::filter(Extinction.estimate == c("Conservative"))


rateFile <- 'N:/Planet-A/Current-Users/Carla-Archibald/Moden-day-extinction-rate/extinction_rate_data_rates.csv'
rateCsv <- read.csv(rateFile)

# counts (or sums of weights)
extinctionsCsv_sub <- extinctionsCsv %>%
               dplyr::filter(!Taxa %in% c("vertebrates")) %>%
               dplyr::filter(!Scale %in% c("Global_HC"))

carlaPallete <- c('#7FB685','#233D4D', '#FE7F2D')
ggplot(extinctionsCsv_sub)+
  geom_col(aes(x=Scale, y=ExtinctionProportion,fill=Extinction.estimate), position ="stack")+
  facet_wrap(~Taxa, scales="free")+
  labs(x = "Taxonomic group",
       y = "Percentage (%) of taxonomic group extinct",
       fill = "Extinction type")+
  scale_fill_manual(values = carlaPallete, labels = c("Expected", "Observed (Highly Conservative)", "Observed (Conservative)"))+
  theme_bw()

ggplot(extinctionsCsv_2)+
  geom_col(aes(x=Scale, y=ExtinctionProportion,fill=ET_Scale), position ="dodge")+
  facet_wrap(~Group, scales="free", nrow =2)+
  labs(x = "Taxonomic group",
       y = "Percentage (%) of taxonomic group extinct",
       fill = "Extinction type")+
  scale_fill_manual(values = carlaPallete, labels = c("Expected", "Observed (Highly Conservative)", "Observed (Conservative)"))+
  theme_bw()



rateCsv_sub <- rateCsv %>%
  dplyr::filter(!Taxa %in% c("vertebrates")) %>%
  dplyr::filter(!Scale %in% c("Global_HC"))

carlaPallete <- c('#FE7F2D','#233D4D')
ggplot(rateCsv_sub)+
  geom_col(aes(x=reorder(Taxa, -Adjusted_extinction_rate), y=Adjusted_extinction_rate,fill=`Scale`), position ="dodge")+
  labs(x = "Taxonomic group",
       y = "Moden-day extinction rate (E/MSY)")+
  scale_fill_manual(values = carlaPallete)+
  theme_bw()+
  theme(legend.title = element_blank(),
        legend.position=c(.85,.9))+
  geom_hline(yintercept = 1, color="black", linetype="dashed", size =1.5)
  
extinctionsCsv


carlaPallete <- c('#FE7F2D','#233D4D')
ggplot(extinctionsCsv)+
  geom_col(aes(x=reorder(Group, -Elevated.extinction.rate.with.respect.to.expected), y=Elevated.extinction.rate.with.respect.to.expected,fill=`Scale`), position ="dodge")+
  labs(x = "Taxonomic group",
       y = "Moden-day extinction rate (E/MSY)")+
  scale_fill_manual(values = carlaPallete)+
  facet_wrap(~Extinction.estimate)+
  theme_bw()+
  theme(legend.title = element_blank(),
        legend.position=c(.85,.9))+
  geom_hline(yintercept = 1, color="black", linetype="dashed", size =1.5)


CFF27E