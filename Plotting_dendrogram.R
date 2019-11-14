setwd("/n/scratchlfs/edwards_lab/gbravo/Genomes/mash/")
library(tidyverse)
library(reshape2)

#species list
species <- c("Gallus_v6", "R_hoffmansi", "R_melanosticta", "S_canadensis", "S_luctuosus", "Taenopygia_v1", "T_atrinucha", "T_bernardi", "T_bridgesi", "T_caerulescens", "T_doliatus", "T_ruficapillus", "T_shumbae")

#Reading data from Mash
raw_from_mash <- read.table("distances.txt") 
distances <- raw_from_mash[,1:3]
dfr <- tbl_df(reshape(distances, direction="wide", idvar="V2", timevar="V1")) %>% add_row(.before = 1) %>% add_column(NA)
dm <- as.matrix(dfr[, -1])
colnames(dm) <- species
rownames(dm) <- species
d <- as.dist(dm, upper = TRUE)

#plotting dendrogram
clust <- hclust(d)
plot(hclust(d), hang = -1)
tree <-as.phylo(clust)
write.tree(tree,"tree.tre")


