#####get phenotype data from "pdata_file", the information in which are extracted from "GSE_family" file downloaded from GEO database.
get_pdata = function(pdata_file){

  ####phenodata
  pdata = read.csv(pdata_file, header = TRUE, row.names = 1)
  pdata
}
