########################################################
#### function to get results of "gsva", "ssgsea", "plage" and "zscore"
########################################################

run_gsva_4methods = function(GSEdata, genesetcollection){
  result.plage = list();
  result.zscore = list();
  result.ssgsea = list();
  result.gsva = list();
  for (i in 1:length(GSEdata)){
    
    result.plage[[i]] = gsva(as.matrix(GSEdata[[i]][-1,]), genesetcollection, method = "plage", 
                             mx.diff = FALSE, parallel.sz=2, abs.ranking = FALSE, verbose=TRUE)
    result.zscore[[i]] = gsva(as.matrix(GSEdata[[i]][-1,]), genesetcollection, method = "zscore", 
                              mx.diff = FALSE, parallel.sz=2, abs.ranking = FALSE, verbose=TRUE)
    result.ssgsea[[i]] = gsva(as.matrix(GSEdata[[i]][-1,]), genesetcollection, method = "ssgsea",
                              mx.diff = FALSE, parallel.sz=2, abs.ranking = FALSE, verbose=TRUE)
    result.gsva[[i]] = gsva(as.matrix(GSEdata[[i]][-1,]), genesetcollection, method = "gsva",
                            mx.diff = FALSE, parallel.sz=2, abs.ranking = FALSE, verbose=TRUE)
    
  }
  result = list("result.plage" = result.plage, "result.zscore" = result.zscore,
                "result.ssgsea" = result.ssgsea, "result.gsva" = result.gsva)
  result
}

###   library(GSEABase)  
###   genesetcollection = getGmt("git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/COPD.target.pathway.symbols.gmt", 
###                              geneIdType = SymbolIdentifier())   ### will produce warning but ignore it
###  gsva_4results_GSE10245 = run_gsva_4methods(GSEdata[[1]], genesetcollection)
###  gsva_4results = run_gsva_4methods(GSEdata, genesetcollection)
