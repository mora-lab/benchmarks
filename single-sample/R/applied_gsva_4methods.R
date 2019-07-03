### Installing package dependencies ###
### installing packages needed ###
###install and load data
##### install.packages("~/PIGSARData/PIGSARData.0.1.2.tar.gz", repos = NULL, type = "source")

####functions to get data
applied_gsva_4methods = function(gse， KEGG_genesetcollection){
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


