########################################################
#### function to get results of "gsva", "ssgsea", "plage" and "zscore"
########################################################

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

###   library(GSEABase)  
###   genesetcollection = getGmt("git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/COPD.target.pathway.symbols.gmt", 
###                              geneIdType = SymbolIdentifier())   ### will produce warning but ignore it
### result_gsva_GSE10245 = run_gsva_4methods(as.matrix(GSE10245$exprsdata), KEGG_genesetcollection)
