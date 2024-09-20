library(rinat)
library(dplyr)

iNatFauna <- get_inat_obs_project("fauna-del-virch", 
                                    type = c("observations"), raw = FALSE) %>%
  filter(quality_grade=="research") %>%
  select(id, taxon.id, taxon.name, latitude, longitude, uri)

iNatFlora <- get_inat_obs_project("flora-del-virch", 
                                      type = c("observations"), raw = FALSE) %>%
  filter(quality_grade=="research") %>%
  select(id, taxon.id, taxon.name, latitude, longitude, uri)

iNatData <- rbind(iNatFauna, iNatFlora)
iNatCheckist <- unique(iNatData$taxon.name)

write.csv(sort(iNatCheckist), "data/iNatChecklist.csv", row.names = F, col.names = F, quote = F)