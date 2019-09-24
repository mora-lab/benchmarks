### ---------------
###
### Create: Chengshu Xie
### Date: 2019-01-20 15:43:52
### Email: shuxcy@126.com
###
### ---------------


get_input_data = function(series_matrix_file, pdata_file, geo_accession, bioc_annotation_package){  ### make sure of the R annotation packages
   
    if (file.exists(series_matrix_file) == TRUE & file.exists(pdata_file) == TRUE ) {
        cat("Reading available file...\n")
        exprSet = read.table(series_matrix_file, header=TRUE, row.names = 1, comment.char="!", sep='\t', quote="")
        pdata = read.table(pdata_file, header=TRUE, row.names = 1, comment.char="!", sep='\t', quote="")
    } else {
        if (!requireNamespace("BiocManager", quietly = TRUE))
            install.packages("BiocManager")
        BiocManager::install("GEOquery")
        library(GEOquery)
        geo_data = getGEO(geo_accession, destdir=".",getGPL = F)
        exprSet = exprs(geo_data[[1]])
        exprSet = as.data.frame(exprSet)
        pdata = pData(geo_data[[1]])    
  }
  
  #### convert probe ids into 
  exprSet$probe_id = rownames(exprSet)
  if (bioc_annotation_package == "hu6800.db") { probe2symbol_df = toTable(get("hu6800SYMBOL"))}
  if (bioc_annotation_package == "hgu133plus2.db") {probe2symbol_df = toTable(get("hgu133plus2SYMBOL"))}
  if (bioc_annotation_package == "illuminaHumanv4.db") { probe2symbol_df = toTable(get("illuminaHumanv4SYMBOL"))}
  if (bioc_annotation_package == "hugene10sttranscriptcluster.db") { probe2symbol_df = toTable(get("hugene10sttranscriptclusterSYMBOL"))}
  newmatrixdata = exprSet %>% 
                  inner_join(probe2symbol_df,by="probe_id") %>% #merge informatio of probe_id
                  select(-probe_id) %>% #remove extra column         
                  select(symbol, everything()) %>% #re-arrange
                  mutate(rowMean = rowMeans(.[grep("GSM", names(.))])) %>% #calculate means
                  arrange(desc(rowMean))  %>% #order the means
                  distinct(symbol,.keep_all = T) %>% # keep the first symbol information
                  select(-rowMean) %>% #remove the new colmun
                  tibble::column_to_rownames(colnames(.)[1]) #convert the first column into rownames and remove it           
  newmatrixdata = as.matrix(newmatrixdata)
  result = list("pdata" = pdata, "exprdata" = newmatrixdata)

  result
}

### try = get_input_data(series_matrix_file = "~/GSE36221_series_matrix.txt", 
###                      pdata_file = "~/GSE36221_pdata.txt",
###                      geo_accession = "GSE36221",
###                      bioc_annotation_package = "hugene10sttranscriptcluster.db")