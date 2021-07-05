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

tree_downloads <- readRDS("PollenEurope-21.RData")

# Creates one spreadsheet of all downloads
comp_dl <- compile_downloads(tree_downloads)
comp.rc <- comp_dl[comp_dl$date.type != "Radiocarbon years BP",]

# Gets total counts for each observation at each site
tot_cnts <- rowSums(comp.rc[,11:ncol(comp.rc)], na.rm=TRUE)

# European pollen taxa: Alnus, Fagus, Picea, Quercus, Spruce
# Linearly interpolates each taxa in bins of 500 years

tot.cnts <- rowSums(pollen.comp.clean[,11:ncol(pollen.comp.clean)], na.rm=TRUE)

interp_dl <- data.frame(pollen.comp.clean[,1:10],
                        time = - (round(pollen.comp.clean$age / 500, 0) * 500),
                        alnus = pollen.comp.clean[, grep("Alnus*", colnames(pollen.comp.clean))] / tot.cnts,
                        fagus = pollen.comp.clean[, grep("Fagus*", colnames(pollen.comp.clean))] / tot.cnts,
                        picea = pollen.comp.clean[, grep("Picea*", colnames(pollen.comp.clean))] / tot.cnts,
                        quercus = pollen.comp.clean[, grep("Quercus*", colnames(pollen.comp.clean))] / tot.cnts) %>%
  dplyr::group_by(time, lat, long, site.name) %>% 
  summarize( Fagus   = mean(fagus)   * 100, 
             Alnus   = mean(alnus)   * 100, 
             Picea   = mean(picea)   * 100, 
             Quercus = mean(quercus) * 100)

common <- c('Beech', 'Alder', 'Spruce', 'Oak')

plant.data <- data.frame()
for (i in 1:length(common)) {
  taxon = common[i]
  samples = interp_dl[,i+4]
  names(samples) <- "samples"
  taxa = rep(taxon,nrow(samples))
  current.taxon.data <- cbind(interp_dl[,1:4],samples,taxa)
  plant.data <- rbind(plant.data,current.taxon.data)
}

colnames(plant.data)[colnames(plant.data) == '...6'] <- 'taxa'
plant.data <- plant.data[order(plant.data$time,plant.data$site.name),]


names.check <- cbind(colnames(comp_dl[1, grep("Alnus*", colnames(comp_dl))]),
                     colnames(comp_dl[1, grep("Fagus*", colnames(comp_dl))]),
                     colnames(comp_dl[1, grep("Picea*", colnames(comp_dl))]),
                     colnames(comp_dl[1, grep("Quercus*", colnames(comp_dl))]))


# Removes any observations from over 21,000 years ago
timefltr_output <- dplyr::filter(plant.data, time >= -21000)
final_output <- na.omit(timefltr_output)

final.output.no0 <- final_output[final_output$samples != 0,]

# Writes CSV file
# Specify location of file via a file path, i.e. file = "home/Code/CartoInputFile"
write.csv(final_output, file = "~/Github/CartoAnimations/other-files/CSVs/CartoInput_Euro_V3.csv")
write.csv(final.output.no0, file = "~/Github/CartoAnimations/other-files/CSVs/CartoInput_Euro_V3_no0.csv")

inputPollen <- "~/Desktop/Github/CartoAnimations/other-files/CSVs/CartoInput_Eur.csv"


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



