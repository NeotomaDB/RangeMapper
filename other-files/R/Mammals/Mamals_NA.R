# This code downloads datasets from Neotoma
# Written by Anna George, 2019
#Syd's mammal attempt

# Loads packages
library(neotoma)

# Figure out your bounding box:
# You can use https://boundingbox.klokantech.com/
# North America bounding box: loc = c(-130, 24, -34, 65)
# Europe bounding box: loc = c(-11, 35, 47, 72)

# Choose interesting taxa:
# NA pollen taxa: Fagus, Picea, Quercus, Spruce, Tsuga
# European pollen taxa: Alnus, Fagus, Picea, Quercus, Spruce
# Australian pollen taxa: Nothofagus, Eucalyptus, Casuarina, Callitris, Pyllocladus
# Mammal taxa: Bison, Smilodon, Panthera, Equus, Rodentia, Mammut, Mammuthus

# Records dataset metadata for the below taxon in specifiied location and 
bison_datasets <- get_dataset(taxonname = 'Bison*',
                              loc = c(-130, 24, -34, 65), 
                              ageyoung = 0, 
                              ageold = 21000)
# Creates list of picea dataset numbers
bison_dataset_numbers <- as.numeric(names(bison_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
smilodon_datasets <- get_dataset(taxonname = 'Smilodon*',
                              loc = c(-130, 24, -34, 65), 
                              ageyoung = 0, 
                              ageold = 21000)
# Creates list of picea dataset numbers
smilodon_dataset_numbers <- as.numeric(names(smilodon_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
panthera_datasets <- get_dataset(taxonname = 'Panthera*',
                                loc = c(-130, 24, -34, 65), 
                                ageyoung = 0, 
                                ageold = 21000)
# Creates list of quercus dataset numbers
panthera_dataset_numbers <- as.numeric(names(panthera_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
equus_datasets <- get_dataset(taxonname = 'Equus*',
                               loc = c(-130, 24, -34, 65), 
                               ageyoung = 0, 
                               ageold = 21000)
# Creates list of spruce dataset numbers
equus_dataset_numbers <- as.numeric(names(equus_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
rodentia_datasets <- get_dataset(taxonname = 'Rodentia*',
                              loc = c(-130, 24, -34, 65), 
                              ageyoung = 0, 
                              ageold = 21000)
# Creates list of tsuga dataset numbers
rodentia_dataset_numbers <- as.numeric(names(rodentia_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
mammut_datasets <- get_dataset(taxonname = 'Mammut*',
                                 loc = c(-130, 24, -34, 65), 
                                 ageyoung = 0, 
                                 ageold = 21000)
# Creates list of tsuga dataset numbers
mammut_dataset_numbers <- as.numeric(names(mammut_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
mammuthus_datasets <- get_dataset(taxonname = 'Mammuthus*',
                               loc = c(-130, 24, -34, 65), 
                               ageyoung = 0, 
                               ageold = 21000)
# Creates list of tsuga dataset numbers
mammuthus_dataset_numbers <- as.numeric(names(mammuthus_datasets))
# Creates empty list 
site_dataset_numbers = list()

# Combines lists of different taxa dataset numbers
site_dataset_numbers <- append(site_dataset_numbers, c(bison_dataset_numbers,
                                                       smilodon_dataset_numbers,
                                                       panthera_dataset_numbers, 
                                                       rodentia_dataset_numbers,
                                                       mammut_dataset_numbers,
                                                       mammuthus_dataset_numbers,
                                                       equus_dataset_numbers)) 

# Removes duplicate dataset numbers
all_dataset_numbers <- as.numeric(unique(site_dataset_numbers))

# Downloads datasets
mammal_downloads <- get_download(all_dataset_numbers)

# Saves datasets as an R dataset file
# So you won't have to redownload all the sites
saveRDS(mammal_downloads, file = "~/Desktop/DataForSyd/NorthAmericaMammalSites.RData")

#you can move this by creating a folder and moving it. 
