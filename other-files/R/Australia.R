# This code downloads datasets from Neotoma
# Written by Anna George, 2019

#Australia seems like it worked, 2/1 -syd

# Loads packages
library(neotoma)

# Figure out your bounding box:
# You can use https://boundingbox.klokantech.com/
# North America bounding box: loc = c(-130, 24, -34, 65)
# Europe bounding box: loc = c(-11, 35, 47, 72)
# Australian bounding box: loc = c(105, -51, 177, 10)
# Australian box includes NZ, but not all of Oceana

# Choose interesting taxa:
# NA pollen taxa: Fagus, Picea, Quercus, Spruce, Tsuga
# European pollen taxa: Alnus, Fagus, Picea, Quercus, Spruce
# Australian pollen taxa: Nothofagus, Eucalyptus, Casuarina, Callitris, Phyllocladus
# Mammal taxa: Bison, Smilodon/Panthera, Equus, Rodentia, Mammut, Mammuthus

#Records dataset metadata for the below taxon in specifiied location and
nothofagus_datasets <- get_dataset(taxonname = 'Nothofagus*',
                              loc = c(105, -51, 177, 10),
                              ageyoung = 0,
                              ageold = 21000)
#Creates list of Nothofagus dataset numbers
nothofagus_dataset_numbers <- as.numeric(names(nothofagus_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
eucalyptus_datasets <- get_dataset(taxonname = 'Eucalyptus*',
                                loc = c(105, -51, 177, 10), 
                                ageyoung = 0, 
                                ageold = 21000)
# Creates list of eucalyptus dataset numbers
eucalyptus_dataset_numbers <- as.numeric(names(eucalyptus_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
casuarina_datasets <- get_dataset(taxonname = 'Casuarina*',
                              loc = c(105, -51, 177, 10), 
                              ageyoung = 0, 
                              ageold = 21000)
# Creates list of casuarina dataset numbers
casuarina_dataset_numbers <- as.numeric(names(casuarina_datasets))

# Records dataset metadata for the below taxon in specifiied location and
cupressaceae_datasets <- get_dataset(taxonname = 'Cupressaceae*',
                              loc = c(105, -51, 177, 10),
                              ageyoung = 0,
                              ageold = 21000)
# Creates list of cupressaceae dataset numbers
cupressaceae_dataset_numbers <- as.numeric(names(cupressaceae_datasets))

# Records dataset metadata for the below taxon in specifiied location and
callitris_datasets <- get_dataset(taxonname = 'Callitris*',
                                     loc = c(105, -51, 177, 10),
                                     ageyoung = 0,
                                     ageold = 21000)
# Creates list of callitris dataset numbers
callitris_dataset_numbers <- as.numeric(names(callitris_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
phyllocladus_datasets <- get_dataset(taxonname = 'Phyllocladus*',
                                  loc = c(105, -51, 177, 10), 
                                  ageyoung = 0, 
                                  ageold = 21000)
# Creates list of pyllocladus dataset numbers
phyllocladus_dataset_numbers <- as.numeric(names(phyllocladus_datasets))

# Creates empty list 
site_dataset_numbers = list()

# Combines lists of different taxa dataset numbers
site_dataset_numbers <- append(site_dataset_numbers, c(nothofagus_dataset_numbers,
                                                       eucalyptus_dataset_numbers,
                                                       casuarina_dataset_numbers,
                                                       callitris_dataset_numbers, 
                                                       phyllocladus_dataset_numbers)) 

# Removes duplicate dataset numbers
all_dataset_numbers <- as.numeric(unique(site_dataset_numbers))

# Downloads datasets
tree_downloads <- get_download(all_dataset_numbers)

# Saves datasets as an R dataset file
# So you won't have to redownload all the sites
saveRDS(tree_downloads, file = "~/Desktop/DataForSyd/Australia_sites.RData")

#you can move this by creating a folder and moving it. 
