library(tidyverse)
library(ggplot2)
library(igraph)
# remotes::install_github("lsaravia/multiweb")
library(multiweb)
library(NetIndices)

directorio <- "C:/Users/ASUS/Documents/GitHub/trophicVIRCH/"

checklist <- read.csv(paste(directorio, "data/checklist.csv", sep = "/"))
interacciones_db <- read.csv(paste(directorio, "data/interacciones.csv", sep = "/"))

interacciones <- interacciones_db %>%
  mutate(Presa_checklist = case_when(Presa_checklist %in% c("Insecta_terrestrial juvenile", "Insecta_terrestrial adult") ~ "Insecta_terrestrial",
                          Presa_checklist %in% c("Insecta_aquatic juvenile", "Insecta_aquatic") ~ "Insecta_aquatic",
                          Presa_checklist %in% c("Oligochaeta") ~ "Clitellata", TRUE ~ Presa_checklist)) %>%
  mutate(Depredador_nodo= case_when(Depredador_nodo %in% c("Insecta_terrestrial juvenile", "Insecta_terrestrial adult") ~ "Insecta_terrestrial",
                                    Depredador_nodo %in% c("Insecta_aquatic juvenile", "Insecta_aquatic adult") ~ "Insecta_aquatic",
                                    Depredador_nodo %in% c("Oligochaeta") ~ "Clitellata", TRUE ~ Depredador_nodo))  %>% 
  group_by(Depredador_nodo, Presa_checklist) %>%
  summarise() %>%
  filter(Presa_checklist!="") %>%
  
  rename(predator=Depredador_nodo,
         prey=Presa_checklist) %>% 
  distinct(prey, predator, .keep_all = TRUE)


g <- graph_from_edgelist(as.matrix(interacciones[,2:1]), directed = TRUE)
plotTrophLevel(g, ylab = "Trophic level",
               vertexLabel = TRUE,
               tk=TRUE)

