---
title: "Range Mapper Repository"
author: "Williams Lab"
affiliation: "University of Wisconsin - Madison"
date: "2/10/2023"
output: html_document
---

## Introduction

Welcome to [Range Mapper](https://geography.wisc.edu/RangeMapper), a set of online interactive and animated visualizations of plant taxon range shifts since the Last Glacial Maximum, and the workflows that allows researchers, web developers, students and other users to extract and visualize taxa-specific, spatio-temporal data from the Neotoma Paleoecology Database Collective [@williams2017neotoma]. This code also establishes a channel between Neotoma and [CARTO](https://carto.com), an online mapping platform where Neotoma data can be visualized and transformed using the [CARTO VL](https://carto.com/developers/carto-vl/) Javascript library.


### Providing Feedback and Contribution

We welcome user contributions to this project. All contributors are expected to follow the code of conduct. Contributors should fork this project and make a pull request indicating the nature of the changes and the intended utility. If, in any place instructions are not clear or more details are required please feel free to contact us by either [raising a GitHub Issue for this repository](https://github.com/NeotomaDB/RangeMapper/issues/new), or emailing Adrian George at aegeorge2@wisc.edu. 

### Development
The development team is made up of Adrian George, Sydney Widell, Jack Williams, and Robert Roth

### Required Files and Services
We used R to perform our Neotoma Query and to sort the data we retrieved. If R is not installed on your machine, you may download the latest version [here](https://www.r-project.org/). An RMD filed [here](link) will provide a step-by-step guide to the rest of our R code. 

We used CARTO VL to map this data. You will need to create a CARTO account to create maps of your own. You can do so [here](https://carto.com/), but we recommend you check with your institution first to see if it has any use agreements with this platform. 


##Funding
This work would not have been possible without funding support from NSF (Grant EAR-1550707), the University of Wisconsin–Madison Graduate School, and the Minnie Riess Detling Trust.

