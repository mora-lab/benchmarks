#####The series_matrix data is downloaded from GEO database, but the data has probe_id as rownames, we want to convert it into entrezIDs.
#####This function, "get_data_with_entrezID()" is used to read the series_matrix data into R and use the annotation bioconductor package to convert the probe ids.
#####When we download the series_matrix data, we can note that there are related sequence platform, so we can match the platform information with annotation bioconductor packages

######### get the matrix data with entrezIDs 
######## "series_matrix_file" parameter means the downloaded file
######## "bioc_annotation_package" parameter means the related annotation bioconductor package
get_data_with_entrezID = function(series_matrix_file, bioc_annotation_package){
    ######## Installing package dependencies
    install.packages("BiocManager")
    BiocManager::install("hu6800.db")
    BiocManager::install("hgug4112a.db")
    BiocManager::install("hgu133plus2.db")
    BiocManager::install("illuminaHumanv4.db")
    BiocManager::install("HsAgilentDesign026652.db")
    BiocManager::install("hugene10sttranscriptcluster.db")
    BiocManager::install("hugene21sttranscriptcluster.db")
    
    ######## Librarying package dependencies 
    library(hu6800.db)
    library(hgug4112a.db)
    library(hgu133plus2.db)
    library(illuminaHumanv4.db)
    library(HsAgilentDesign026652.db)
    library(hugene21sttranscriptcluster.db)
    library(hugene10sttranscriptcluster.db)
    
  #### read matrix data into R
  matrixdata = read.csv(series_matrix_file, header = TRUE, row.names = 1)
  matrixdata = as.data.frame(matrixdata)
  
  #### convert probe ids into entrezIDs
  matrixdata$probe_id = rownames(matrixdata)
  if (bioc_annotation_package == "hu6800.db") { probe_ENTREZID = toTable(hu6800ENTREZID)}
  if (bioc_annotation_package == "hgu133plus2.db") {probe_ENTREZID = toTable(hgu133plus2ENTREZID)}
  if (bioc_annotation_package == "illuminaHumanv4.db") { probe_ENTREZID = toTable(illuminaHumanv4ENTREZID)}
  if (bioc_annotation_package == "HsAgilentDesign026652.db") { probe_ENTREZID = toTable(HsAgilentDesign026652ENTREZID)}
  if (bioc_annotation_package == "hugene10sttranscriptcluster.db") { probe_ENTREZID = toTable(hugene10sttranscriptclusterENTREZID)}
  if (bioc_annotation_package == "hugene21sttranscriptcluster.db") { probe_ENTREZID = toTable(hugene21sttranscriptclusterENTREZID)}
  newmatrixdata = merge(probe_ENTREZID, matrixdata, by = "probe_id")
  newmatrixdata$probe_id = NULL
  newmatrixdata = aggregate(newmatrixdata[,-1], list(newmatrixdata$gene_id), FUN = median)
  rownames(newmatrixdata) = newmatrixdata$Group.1
  
  #### remove the extra first column and make the data as "matrix" data 
  newmatrixdata = newmatrixdata[,-1]
  newmatrixdata = as.matrix(newmatrixdata)
  newmatrixdata
}
