# This code does linearly interpolates taxa data downloaded from Neotoma
# Written by Anna George, 2019
#N. America, by syd, 2/1
#Syd added upload 2/25

# Loads necessary packages
library(neotoma)
library(dplyr)
library(httr)

# Loads downloaded RData object
# See downloadDatasets.R to download datasets

tree_downloads <- readRDS("~/Desktop/DataForSyd/NorthAmericaSites.RData")

# Creates one spreadsheet of all downloads
comp_dl <- compile_downloads(tree_downloads)

# Gets total counts for each observation at each site
tot_cnts <- rowSums(comp_dl[,11:ncol(comp_dl)], na.rm=TRUE)

# Australian pollen taxa: Nothofagus, Eucalyptus, Casuarina, (Callitris), Phyllocladus
# Linearly interpolates each taxa in bins of 500 years
#Fagus, Picea, Quercus,Tsuga

interp_dl <- data.frame(comp_dl[,1:10],
                        time = - (round(comp_dl$age / 500, 0) * 500),
                        fagus = rowSums(comp_dl[, grep("Fagus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        picea = rowSums(comp_dl[, grep("Picea*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        quercus = rowSums(comp_dl[, grep("Quercus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        tsuga = rowSums(comp_dl[, grep("Tsuga*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts) %>%
  group_by(time, lat, long, site.name) %>%
  summarize( fagus = mean ( fagus) * 100, picea = mean ( picea) * 100, quercus = mean (quercus) * 100, tsuga = mean (tsuga) * 100)

# Removes any observations from over 21,000 years ago
timefltr_output <- dplyr::filter(interp_dl, time >= -21000)
final_output <- na.omit(timefltr_output)

# Writes CSV file
# Specify location of file via a file path, i.e. file = "home/Code/CartoInputFile"
write.csv(final_output, file = "~/Desktop/Github/CartoAnimations/CSVs/CartoInput_NA.csv")

#https://"YOUR CARTO ACCOUNT".carto.com/api/v1/imports/?api_key="YOUR API KEY"
apiurl <- "https://wisc.carto.com/u/widell/api/v1/imports/?api_key=7de5ebf57ee0f31ed45302fb9c0b3a90723921ae"

inputFile <- "CartoInput_NA.csv"

#writeLines(addresses, addressFile)

writeLines(inputFile)

resp<-POST(apiurl, body=upload_file("CartoInput_NA.csv"), encode="multipart")
content(resp)