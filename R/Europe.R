# This code downloads datasets from Neotoma
# Written by Anna George, 2019
# Europe by Syd, 1/25.
#seems like there are some problems with spruce? maybe these should be picea?

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

# Records dataset metadata for the below taxon in specifiied location and 
alnus_datasets <- get_dataset(taxonname = 'Alnus*',
                              loc = c(-11, 35, 47, 72), 
                              ageyoung = 0, 
                              ageold = 21000)
# Creates list of picea dataset numbers
alnus_dataset_numbers <- as.numeric(names(alnus_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
fagus_datasets <- get_dataset(taxonname = 'fagus*',
                              loc = c(-11, 35, 47, 72), 
                              ageyoung = 0, 
                              ageold = 21000)
# Creates list of picea dataset numbers
fagus_dataset_numbers <- as.numeric(names(fagus_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
picea_datasets <- get_dataset(taxonname = 'Picea*',
                              loc = c(-11, 35, 47, 72), 
                              ageyoung = 0, 
                              ageold = 21000)
# Creates list of picea dataset numbers
picea_dataset_numbers <- as.numeric(names(picea_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
quercus_datasets <- get_dataset(taxonname = 'Quercus*',
                                loc = c(-11, 35, 47, 72), 
                                ageyoung = 0, 
                                ageold = 21000)
# Creates list of quercus dataset numbers
quercus_dataset_numbers <- as.numeric(names(quercus_datasets))

# Records dataset metadata for the below taxon in specifiied location and 
spruce_datasets <- get_dataset(taxonname = 'Spruce*',
                               loc = c(-11, 35, 47, 72), 
                               ageyoung = 0, 
                               ageold = 21000)
# Creates list of spruce dataset numbers
spruce_dataset_numbers <- as.numeric(names(spruce_datasets))


# Creates empty list 
site_dataset_numbers = list()

# Combines lists of different taxa dataset numbers
site_dataset_numbers <- append(site_dataset_numbers, c(alnus_dataset_numbers,
                                                       fagus_dataset_numbers,
                                                       picea_dataset_numbers,
                                                       quercus_dataset_numbers, 
                                                       spruce_dataset_numbers)) 

# Removes duplicate dataset numbers
all_dataset_numbers <- as.numeric(unique(site_dataset_numbers))

# Downloads datasets
tree_downloads <- get_download(all_dataset_numbers)

# Saves datasets as an R dataset file
# So you won't have to redownload all the sites
saveRDS(tree_downloads, file = "Europe_sites.RData")

#you can move this by creating a folder and moving it. 
