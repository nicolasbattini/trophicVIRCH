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
  filter(Confiabilidad!="Baja") %>% 
  # mutate(Presa_checklist = case_when(Presa_checklist %in% c("Oligochaeta") ~ "Clitellata", TRUE ~ Presa_checklist)) %>%
  #mutate(Depredador_nodo= case_when(Depredador_nodo %in% c("Insecta_terrestrial juvenile", "Insecta_terrestrial adult") ~ "Insecta_terrestrial"))  %>% 
  group_by(Depredador_nodo, Presa_checklist) %>%
  summarise() %>%
  filter(Presa_checklist!="") %>%
  rename(predator=Depredador_nodo,
         prey=Presa_checklist) %>% 
  distinct(prey, predator, .keep_all = TRUE)


g <- graph_from_edgelist(as.matrix(interacciones[,2:1]), directed = TRUE)

plotTrophLevel(g, ylab = "Trophic level",
               vertexLabel = TRUE,
               vertexSizeMin = 1,
               vertexSizeFactor = 10,
               tk=TRUE)

grado_in <- degree(g,
                mode = "in")
grado_out <- degree(g,
                   mode = "out")
grado <- as.data.frame(cbind(grado_in, grado_out))
