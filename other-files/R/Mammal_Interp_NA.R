# This code does linearly interpolates taxa data downloaded from Neotoma
# Written by Anna George, 2019
#N. America, by syd, 2/18

# Loads necessary packages
library(neotoma)
library(dplyr)
library(httr)

# Loads downloaded RData object
# See downloadDatasets.R to download datasets

mammal_downloads <- readRDS("~/Desktop/DataForSyd/NorthAmericaMammalSites.RData")

# Creates one spreadsheet of all downloads
comp_dl <- compile_downloads(mammal_downloads)

# Gets total counts for each observation at each site
tot_cnts <- rowSums(comp_dl[,11:ncol(comp_dl)], na.rm=TRUE)

# Australian pollen taxa: Nothofagus, Eucalyptus, Casuarina, (Callitris), Phyllocladus
# Linearly interpolates each taxa in bins of 500 years
#Fagus, Picea, Quercus,Tsuga

interp_dl <- data.frame(comp_dl[,1:10],
                        time = - (round(comp_dl$age / 500, 0) * 500),
                        bison = rowSums(comp_dl[, grep("Bison*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        smilodon = rowSums(comp_dl[, grep("Smilodon*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        panthera = rowSums(comp_dl[, grep("Panthera*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        mammuthus = rowSums(comp_dl[, grep("Mammuthus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        equus = rowSums(comp_dl[, grep("Equus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        mammut = rowSums(comp_dl[, grep("Mammut*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts, 
                        rodentia = rowSums(comp_dl[, grep("Rodentia*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts) %>%
  group_by(time, lat, long, site.name) %>%
  summarize( bison = mean ( bison) * 100, 
             smilodon = mean ( smilodon) * 100, 
             panthera = mean (panthera) * 100, 
             mammuthus = mean (mammuthus) * 100, 
             mammut = mean (mammut) * 100,
             equus = mean (equus) * 100,
             rodentia = mean (rodentia) * 100)

# Removes any observations from over 21,000 years ago
timefltr_output <- dplyr::filter(interp_dl, time >= -21000)
final_output <- na.omit(timefltr_output)

# Writes CSV file
# Specify location of file via a file path, i.e. file = "home/Code/CartoInputFile"
write.csv(final_output, file = "CartoInputMammals_NA.csv")

#apiurl <- "https://documentation.carto.com/api/v1/imports/?api_key=2b8175051e465979cce3424b18b49846d1461e48"

#inputfile <- "CartoInputMammals_NA.csv"

#writeLines(addresses , addresseFile )

#resp<-POST(apiurl, body=upload_file("CartoInput_NA_V3.csv"), encode="multipart")
#content(resp)
