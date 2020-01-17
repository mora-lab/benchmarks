if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("R.utils");
BiocManager::install("GEOquery");
BiocManager::install("tidyverse");
BiocManager::install("hgu133plus2.db");
BiocManager::install("pathifier");
BiocManager::install("GSVAdata");
BiocManager::install("GSEABase");
BiocManager::install("GSVA");
BiocManager::install("limma");
BiocManager::install("metap");
BiocManager::install("pheatmap");
BiocManager::install("ggplot2");
BiocManager::install("shinythemes");
BiocManager::install("shiny");

library(R.utils);
library(GEOquery);
library(tidyverse);
library(pathifier);
library(GRAPE);
library(GSVAdata);
library(GSEABase);
library(GSVA);
library(limma);
library(metap)
library(pheatmap);
library(ggplot2);
library(shinythemes)
library(shiny)

source("R/read_file.R"); 
source("R/get_microarray_data.R");
# source("R/ID_conversion.R")
source("R/format_input_GRAPE.R");
source("R/format_input_pathifier.R"); 
source("R/run_gsva_4methods.R");
source("R/run_GRAPE.R");
source("R/run_pathifier.R"); 


msig_data <- readRDS("data/msig_data.RDS");
genesetcollection <- readRDS("data/genesetcollection.RDS");

# genesetcollection = getGmt("E:/SSbenchmark_test/data/c2.cp.v7.0.symbols.gmt", 
#                            geneIdType = EntrezIdentifier(), 
#                            collectionType = BroadCollection(category="c2"))
# saveRDS(genesetcollection, "data/genesetcollection.RDS")
read_gmt = function(file){
  if(!grepl("\\.gmt$",file)[1]){stop("Pathway information must be a .gmt file")}; 
  geneSetDB = readLines(file);                                    ##read in the gmt file as a vector of lines
  geneSetDB = strsplit(geneSetDB,"\t");                           ##convert from vector of strings to a list
  names(geneSetDB) = sapply(geneSetDB,"[",1);                     ##move the names column as the names of the list
  geneSetDB = lapply(geneSetDB, "[",-1:-2);                       ##remove name and description columns
  geneSetDB = lapply(geneSetDB, function(x){x[which(x!="")]});    ##remove empty strings
  return(geneSetDB);
}
datat2 <- getGmt("E:/SSbenchmark_test/data/Asthma.target.pathway.symbols.gmt")

### function to get pathway data to be used 
# source("E:/SSbenchmark_test//R/read_gmt.R")
pathwaylist = read_gmt("E:/SSbenchmark_test/data/c2.cp.v7.0.symbols.gmt");
target.Asthma = read_gmt("E:/SSbenchmark_test/data/Asthma.target.pathway.symbols.gmt");
target.COPD = read_gmt("E:/SSbenchmark_test/data/COPD.target.pathway.symbols.gmt");
target.NSCLC = read_gmt("E:/SSbenchmark_test/data/NSCLC.target.pathway.symbols.gmt");
target.Tuber = read_gmt("E:/SSbenchmark_test/data/Tuberclosis.target.pathway.symbols.gmt");
### save data
saveRDS(pathwaylist, "E:/SSbenchmark_test/results/data objects/pathwaylist.RDS")


datat = read_file("example/example.csv")
