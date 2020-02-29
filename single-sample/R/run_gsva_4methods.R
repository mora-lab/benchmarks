### ---------------
### Create: Chengshu Xie
### Date: 2019-01-20 15:43:52
### Email: shuxcy@126.com
### ---------------

run_gsva_4methods = function(expdata, genesetcollection){
    result.plage = list();
    result.zscore = list();
    result.ssgsea = list();
    result.gsva = list();
    result.plage = gsva(as.matrix(expdata[-1,]), genesetcollection, method = "plage", 
                        mx.diff = FALSE, parallel.sz=2, abs.ranking = FALSE, verbose=TRUE)
    result.zscore = gsva(as.matrix(expdata[-1,]), genesetcollection, method = "zscore", 
                         mx.diff = FALSE, parallel.sz=2, abs.ranking = FALSE, verbose=TRUE)
    result.ssgsea = gsva(as.matrix(expdata[-1,]), genesetcollection, method = "ssgsea",
                         mx.diff = FALSE, parallel.sz=2, abs.ranking = FALSE, verbose=TRUE)
    result.gsva = gsva(as.matrix(expdata[-1,]), genesetcollection, method = "gsva",
                       mx.diff = FALSE, parallel.sz=2, abs.ranking = FALSE, verbose=TRUE)
    result = list("result.plage" = result.plage, "result.zscore" = result.zscore,
                  "result.ssgsea" = result.ssgsea, "result.gsva" = result.gsva)
    result
}

###  library(GSEABase)
###  genesetcollection = getGmt("git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/COPD.target.pathway.symbols.gmt", 
###                             geneIdType = SymbolIdentifier())   ### will produce warning but ignore it
###  GSE10245 = get_microarray_data(geo_accession = "GSE10245",
###                                 pdata_file = "git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/GSE10245_pdata.csv",                      
###                                 bioc_annotation_package = "hgu133plus2.db")
###  gsva_4results_GSE10245 = run_gsva_4methods(GSE10245[-1,], genesetcollection)
