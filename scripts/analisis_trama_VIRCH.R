library(dplyr)

directorio <- "N:/Mi unidad/Proyectos/Corbicula/Trama trófica del Río Chubut"
setwd(directorio)

checklist <- read.csv(paste(directorio, "checklist.csv", sep = "/"))
interacciones_db <- read.csv(paste(directorio, "interacciones.csv", sep = "/"))

interacciones <- na.omit(interacciones_db) %>%
  group_by(Depredador_nodo, Presa_checklist) %>%
  summarise()

