# This code downloads datasets from Neotoma
# Written by Anna George, 2019
#North America, done! 2/1 -syd

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
# Mammal taxa: Bison, Smilodon/Panthera, Equus, Rodentia, Mammut, Mammuthus

##TREES

# Records dataset metadata for the below taxon in specifiied location and 
alnus_datasets <- get_dataset(taxonname = 'Alnus*',
                              loc = c(-130, 24, -34, 65), 
                              ageyoung = 0, 
                              ageold = 18000)
# Creates list of dataset numbers
alnus_dataset_numbers <- as.numeric(names(alnus_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
fagus_datasets <- get_dataset(taxonname = 'Fagus*',
                              loc = c(-130, 24, -34, 65), 
                              ageyoung = 0, 
                              ageold = 18000)
# Creates list of dataset numbers
fagus_dataset_numbers <- as.numeric(names(fagus_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
picea_datasets <- get_dataset(taxonname = 'Picea*',
                                loc = c(-130, 24, -34, 65), 
                                ageyoung = 0, 
                                ageold = 18000)
# Creates list of picea dataset numbers
picea_dataset_numbers <- as.numeric(names(picea_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
pinus_datasets <- get_dataset(taxonname = 'Pinus*',
                              loc = c(-130, 24, -34, 65), 
                              ageyoung = 0, 
                              ageold = 18000)
# Creates list of picea dataset numbers

pinus_dataset_numbers <- as.numeric(names(pinus_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
quercus_datasets <- get_dataset(taxonname = 'Quercus*',
                              loc = c(-130, 24, -34, 65), 
                              ageyoung = 0, 
                              ageold = 18000)
# Creates list of dataset numbers
quercus_dataset_numbers <- as.numeric(names(quercus_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
spruce_datasets <- get_dataset(taxonname = 'Spruce*',
                              loc = c(-130, 24, -34, 65), 
                              ageyoung = 0, 
                              ageold = 18000)
# Creates list of  dataset numbers
spruce_dataset_numbers <- as.numeric(names(spruce_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
tsuga_datasets <- get_dataset(taxonname = 'Tsuga*',
                               loc = c(-130, 24, -34, 65), 
                               ageyoung = 0, 
                               ageold = 18000)
# Creates list of dataset numbers
tsuga_dataset_numbers <- as.numeric(names(tsuga_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
ulmus_datasets <- get_dataset(taxonname = 'Ulmus*',
                              loc = c(-130, 24, -34, 65), 
                              ageyoung = 0, 
                              ageold = 18000)
# Creates list of dataset numbers
ulmus_dataset_numbers <- as.numeric(names(ulmus_datasets))

##HERBACEOUS 

# Records dataset metadata for the below taxon in specifiied location and 
#asteraceae_datasets <- get_dataset(taxonname = 'Asteraceae*',
                                   #loc = c(-130, 24, -34, 65), 
                                   #ageyoung = 0, 
                                   #ageold = 21000)
# Creates list of dataset numbers
#asteraceae_dataset_numbers <- as.numeric(names(asteraceae_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
ambrosia_datasets <- get_dataset(taxonname = 'Ambrosia*',
                                   loc = c(-130, 24, -34, 65), 
                                   ageyoung = 0, 
                                   ageold = 18000)
# Creates list of dataset numbers
ambrosia_dataset_numbers <- as.numeric(names(ambrosia_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
cyperaceae_datasets <- get_dataset(taxonname = 'Cyperaceae*',
                                loc = c(-130, 24, -34, 65), 
                                ageyoung = 0, 
                                ageold = 18000)
# Creates list of dataset numbers
cyperaceae_dataset_numbers <- as.numeric(names(cyperaceae_datasets))


poaceae_datasets <- get_dataset(taxonname = 'Poaceae*',
                              loc = c(-130, 24, -34, 65), 
                              ageyoung = 0, 
                              ageold = 18000)
# Creates list of dataset numbers
poaceae_dataset_numbers <- as.numeric(names(poaceae_datasets))

# Creates empty list 
site_dataset_numbers = list()

# Combines lists of different taxa dataset numbers
site_dataset_numbers <- append(site_dataset_numbers, c(#TREES
                                                       alnus_dataset_numbers,
                                                       fagus_dataset_numbers,
                                                       picea_dataset_numbers,
                                                       pinus_dataset_numbers,
                                                       quercus_dataset_numbers, 
                                                       tsuga_dataset_numbers,
                                                       spruce_dataset_numbers,
                                                       ulmus_dataset_numbers,
                                                       #HERBS
                                                       ambrosia_dataset_numbers, 
                                                       #astercaceae_dataset_numbers,
                                                       cyperaceae_dataset_numbers,
                                                       poaceae_dataset_numbers)) 

# Removes duplicate dataset numbers
all_dataset_numbers <- as.numeric(unique(site_dataset_numbers))

# Downloads datasets
tree_downloads <- get_download(all_dataset_numbers)

# Saves datasets as an R dataset file
# So you won't have to redownload all the sites
saveRDS(tree_downloads, file = "~/Desktop/DataForSyd/NorthAmericaSites.RData")


