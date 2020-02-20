# This code does linearly interpolates taxa data downloaded from Neotoma
# Written by Anna George, 2019
#N. America, by syd, 2/1
#Syd fixed upload 3/25

# Loads necessary packages
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
                        alnus = rowSums(comp_dl[, grep("Alnus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        fagus = rowSums(comp_dl[, grep("Fagus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        picea = rowSums(comp_dl[, grep("Picea*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        pinus = rowSums(comp_dl[, grep("Pinus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        quercus = rowSums(comp_dl[, grep("Quercus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        tsuga = rowSums(comp_dl[, grep("Tsuga*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        ulmus = rowSums(comp_dl[, grep("Ulmus*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        ambrosia = rowSums(comp_dl[, grep("Ambrosia*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        cyperaceae = rowSums(comp_dl[, grep("Cyperaceae*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts,
                        poaceae = rowSums(comp_dl[, grep("Poaceae*", colnames(comp_dl))], na.rm = TRUE) / tot_cnts)%>%
  group_by(time, lat, long, site.name) %>%
  summarize( Alnus = mean ( alnus) * 100, 
             Fagus = mean ( fagus) * 100, 
             Picea = mean ( picea) * 100,
             Pinus = mean ( pinus) * 100, 
             Quercus = mean (quercus) * 100, 
             Tsuga = mean (tsuga) * 100,
             Ulmus = mean ( ulmus) * 100,
             Ambrosia = mean ( ambrosia) * 100, 
             Cyperaceae = mean ( cyperaceae) * 100,
             Poaceae = mean ( poaceae) * 100)

# Add blank legendvalues column
legendvalues <- rep(0,length.out = nrow(interp_dl))
interp_dl$legendvalues <- rep(NULL,length.out = nrow(interp_dl))                 
                    
# Creates table for legend
time_bins <- rep(seq(0, -21000, -500), each = 3)
blank_pollen <- as.data.frame(matrix(0, ncol = ncol(interp_dl, nrow = length(time_bins))))
c(rep(0, length.out = ncol(interp_dl)-4))

legenddata <- data.frame(time_bins, 
                         rep(0,length.out = length(time_bins)), 
                         rep(0,length.out = length(time_bins)), 
                         rep("legendsite",length.out = length(time_bins)), 
                         cbind(), 
                         rep(c(10, 50, 100),length.out = length(time_bins)))
names(legenddata) <- c("time", "lat", "long", "site.name", names(5:ncol(interp_dl)), "legendvalues")

interp_dl_legend <- rbind(interp_dl,legenddata)

# Removes any observations from over 21,000 years ago
timefltr_output <- dplyr::filter(interp_dl, time >= -21000)
final_output <- na.omit(timefltr_output)

#To make the legend
legendvalues <- rep(c(10, 50, 100), length.out = nrow(final_output[,1]))
final_output$legendvalues = legendvalues

# Writes CSV file
# Specify location of file via a file path, i.e. file = "home/Code/CartoInputFile"

write.csv(final_output, file = "~/Desktop/Github/CartoAnimations/other-files/CSVs/CartoInput_NA.csv")
inputPollen <- "~/Desktop/Github/CartoAnimations/other-files/CSVs/CartoInput_NA.csv"
inputIcesheets <- "~/Desktop/Github/CartoAnimations/other-files/old-carto-html/icesheets.geojson"

# This section posts the file you just created and saved locally to R
# This needs 

#your carto info
carto_acc = "widell"
carto_api = "7de5ebf57ee0f31ed45302fb9c0b3a90723921ae"

#optional:
#test_connection()

#Post the file!

local_import(inputPollen)
local_import(inputIcesheets)


