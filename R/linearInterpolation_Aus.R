# This code does linearly interpolates taxa data downloaded from Neotoma
# Written by Anna George, 2019
#Australia, by syd, 2/1

# Loads necessary packages
library(neotoma)
library(dplyr)
library(httr)

# Loads downloaded RData object
# See downloadDatasets.R to download datasets

tree_downloads <- readRDS("~/Desktop/DataForSyd/Australia_sites.RData")

# Creates one spreadsheet of all downloads
comp_dl <- compile_downloads(tree_downloads)

# Gets total counts for each observation at each site
tot_cnts <- rowSums(comp_dl[,11:ncol(comp_dl)], na.rm=TRUE)

# Australian pollen taxa: Nothofagus, Eucalyptus, Casuarina, (Callitris), Phyllocladus
# Linearly interpolates each taxa in bins of 500 years

interp_dl <- data.frame(comp_dl[,1:10],
                        time = - (round(comp_dl$age / 500, 0) * 500),
                        nothofagus = rowSums(comp_dl[, grep("Nothofagus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        eucalyptus = rowSums(comp_dl[, grep("Eucalyptus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        casuarina = rowSums(comp_dl[, grep("Casuarina*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        callitris = rowSums(comp_dl[, grep("Callitris*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        phyllocladus = rowSums(comp_dl[, grep("Phyllocladus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts) %>%
  group_by(time, lat, long, site.name) %>%
  summarize( nothofagus = mean ( nothofagus) * 100, phyllocladus = mean ( phyllocladus) * 100, casuarina = mean (casuarina) * 100, callitris = mean (callitris) * 100, eucalyptus = mean (eucalyptus) * 100)

# Removes any observations from over 21,000 years ago
timefltr_output <- dplyr::filter(interp_dl, time >= -21000)
final_output <- na.omit(timefltr_output)

# Writes CSV file
# Specify location of file via a file path, i.e. file = "home/Code/CartoInputFile"
write.csv(final_output, file = "CartoInput_Aus.csv")

#apiurl <- "https://documentation.carto.com/api/v1/imports/?api_key=2b8175051e465979cce3424b18b49846d1461e48"

#inputfile <- "CartoInput_NA_V3.csv"

#writeLines(addresses , addresseFile )

#resp<-POST(apiurl, body=upload_file("CartoInput_NA_V3.csv"), encode="multipart")
#content(resp)
