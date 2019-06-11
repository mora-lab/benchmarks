######## get phenotype data related to GSEdata  
###### pheno meta-data, a overview of phenotype data that could be used. 
pheno_metadata <- data.frame(labelDescription= c("organism of samples", "sample type", "sample source(tissue)","subtype", "sample description", "Normal"),
                             row.names=c("Sample_organism_ch1", "Sample_type",	"Sample_source_name_ch1", "subtype", "Sample_description", "Normal"))

#####get phenotype data from "pdata_file", the information in which are extracted from "GSE_family" file downloaded from GEO database.
get_pdata = function(pdata_file){

  ####phenodata
  pdata = read.csv(pdata_file, header = TRUE, row.names = 1)
  pdata
}

#### example to get phenotype data
GSE1122_pdata = get_pdata("data/GSE1122_pdata.csv")
