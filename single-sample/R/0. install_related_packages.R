### ---------------
###
### Create: Chengshu Xie
### Date: 2019-01-20 15:43:52
### Email: shuxcy@126.com
###
### ---------------


install.packages("R.utils")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install(c("GEOquery", "GSVAdata"), ask = F,update = F)
BiocManager::install(c("hgu133plus2.db","hugene10sttranscriptcluster.db", "illuminaHumanv4.db") ,ask = F,update = F)
BiocManager::install(c("GSEABase","GSVA","pathifier" ),ask = F,update = F)
BiocManager::install(c("individPath","GRAPE" ),ask = F,update = F)
BiocManager::install(c("limma","pheatmap", "ggplot2"),ask = F,update = F)


library(R.utils)
library(GEOquery)
library(GSEABase)
library(limma)
library(GSVAdata)
library(hgu133plus2.db
library(hugene10sttranscriptcluster.db)
library(illuminaHumanv4.db)
library(GSEABase)
library(GSVA)
library(pathifier)
library(individPath)
library(GRAPE)
library(limma)
library(pheatmap)
library(ggplot2)
