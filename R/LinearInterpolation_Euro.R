# This code does linearly interpolates taxa data downloaded from Neotoma
# Written by Anna George, 2019
#Europe by syd, 1/28
#syd fixed upload 3/25


# Loads packages
library(neotoma)
library(dplyr)
library(httr)

#If you don't have these next two packages, here's how to get them!
#They'll be useful for uploading local files to Carto, based on 
#(https://dracodoc.github.io/2017/01/21/rCarto/)

#install.packages("devtools")
#devtools::install_github("dracodoc/rCartoAPI")

#If that doesn't work, try

#install.packages("remotes")
#remotes::install_github("dracodoc/rCartoAPI")

library(devtools)
library(rCartoAPI)

#This section saves your account info in the R environment. 
#It's not working for me, so I skipped it. If you think there's a 
#security risk in having the api key out and about we can try to make 
#this work. Code will run without it.

#file.edit("~/.Renviron")
#setup_key()


#This section creates the file

# Loads downloaded RData object
# See downloadDatasets.R to download datasets

tree_downloads <- readRDS("Europe_sites.RData")

# Creates one spreadsheet of all downloads
comp_dl <- compile_downloads(tree_downloads)

# Gets total counts for each observation at each site
tot_cnts <- rowSums(comp_dl[,11:ncol(comp_dl)], na.rm=TRUE)

# European pollen taxa: Alnus, Fagus, Picea, Quercus, Spruce
# Linearly interpolates each taxa in bins of 500 years

interp_dl <- data.frame(comp_dl[,1:10],
                        time = - (round(comp_dl$age / 500, 0) * 500),
                        alnus = rowSums(comp_dl[, grep("Alnus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        fagus = rowSums(comp_dl[, grep("Fagus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        picea = rowSums(comp_dl[, grep("Picea*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        quercus = rowSums(comp_dl[, grep("Quercus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts) %>%
  group_by(time, lat, long, site.name) %>%
  summarize( fagus = mean ( fagus) * 100, alnus = mean ( alnus) * 100, picea = mean (picea) * 100, quercus = mean (quercus) * 100)

# Removes any observations from over 21,000 years ago
timefltr_output <- dplyr::filter(interp_dl, time >= -21000)
final_output <- na.omit(timefltr_output)

# Writes CSV file
# Specify location of file via a file path, i.e. file = "home/Code/CartoInputFile"
write.csv(final_output, file = "~/Desktop/Github/CartoAnimations/CSVs/CartoInput_Eur.csv")
inputPollen <- "~/Desktop/Github/CartoAnimations/CSVs/CartoInput_Eur.csv"


#writeLines(addresses, addressFile)

writeLines(inputPollen)


#This section posts the file you just created and saved locally to R

#your carto info
carto_acc = "widell"
carto_api = "7de5ebf57ee0f31ed45302fb9c0b3a90723921ae"

#optional:
#test_connection()

#Post the file!

local_import(inputPollen)



