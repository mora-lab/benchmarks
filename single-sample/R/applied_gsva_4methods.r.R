### Installing package dependencies ###
### installing packages needed ###
###install and load data
load("~/PIGSARData/.RData")
##### install.packages("~/PIGSARData/PIGSARData.0.1.2.tar.gz", repos = NULL, type = "source")
####Geneset file
KEGG_genesetcollection = getGmt("F:/lab_data/3. MSigDB files/c2.cp.kegg.v6.2.entrez.gmt",
                                geneIdType = EntrezIdentifier(),
                                collectionType = BroadCollection(category="c2"))
KEGG_genesetcollection

####functions to get data
applied_gsva_4methods =function(gse){
  if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
  BiocManager::install("Biobase")
  BiocManager::install("GSVA")
  BiocManager::install("GSVAdata")
  library(Biobase)
  library(GSVA)
  library(GSVAdata)
  
  if (identical(class(gse), "matrix") == TRUE){
    result.gsva = gsva(gse, KEGG_genesetcollection, method = "gsva", mx.diff = FALSE, parallel.sz=1, abs.ranking = FALSE, verbose=TRUE)
    result.plage = gsva(gse, KEGG_genesetcollection, method = "plage", mx.diff = FALSE, parallel.sz=1, abs.ranking = FALSE, verbose=TRUE)
    result.ssgsea = gsva(gse, KEGG_genesetcollection, method = "ssgsea", mx.diff = FALSE, parallel.sz=1, abs.ranking = FALSE, verbose=TRUE)
    result.zscore = gsva(gse, KEGG_genesetcollection, method = "zscore", mx.diff = FALSE, parallel.sz=1, abs.ranking = FALSE, verbose=TRUE)
    result = list("result.ssgsea" = result.ssgsea, "result.plage" = result.plage, 
                  "result.gsva" = result.gsva, "result.zscore" = result.zscore)
  }
}

###results of each dataset
r12 = applied_gsva_4methods(GSE50834_setentrez)
r13 = applied_gsva_4methods(GSE52819_setentrez)

####combine datasets due to the disease
cluster_H00342 = list("GSE50834" = r12,"GSE52819" = r13)
