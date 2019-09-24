### Installing package dependencies ###
### installing packages needed ###
###install and load data
##### install.packages("~/PIGSARData/PIGSARData.0.1.2.tar.gz", repos = NULL, type = "source")
####  library(Biobase)
####  library(GSVA)
####  library(GSVAdata) 
####functions to get data

run_gsva_4methods = function(gse， KEGG_genesetcollection){

  if (identical(class(gse), "matrix") == TRUE){
    result.gsva = gsva(gse, KEGG_genesetcollection, method = "gsva", mx.diff = FALSE, parallel.sz=1, abs.ranking = FALSE, verbose=TRUE)
    result.plage = gsva(gse, KEGG_genesetcollection, method = "plage", mx.diff = FALSE, parallel.sz=1, abs.ranking = FALSE, verbose=TRUE)
    result.ssgsea = gsva(gse, KEGG_genesetcollection, method = "ssgsea", mx.diff = FALSE, parallel.sz=1, abs.ranking = FALSE, verbose=TRUE)
    result.zscore = gsva(gse, KEGG_genesetcollection, method = "zscore", mx.diff = FALSE, parallel.sz=1, abs.ranking = FALSE, verbose=TRUE)
    result = list("result.ssgsea" = result.ssgsea, "result.plage" = result.plage, 
                  "result.gsva" = result.gsva, "result.zscore" = result.zscore)
  }
}


