### ---------------
### Create: Chengshu Xie
### Date: 2019-01-20 15:43:52
### Email: shuxcy@126.com
### ---------------

get_microarray_data = function(geo_accession, pdata_file, bioc_annotation_package){  
  
  ### download GEO file
  geo_data = getGEO(geo_accession, destdir=".",getGPL = F)
  exprSet = as.data.frame(exprs(geo_data[[1]]))
  
  ### read phenotype data into R
  pdata = read.csv(pdata_file, header = T, row.names = 1)
  
  ### match, select data needed and adjust the data structure
  exprSet = exprSet[which(colnames(exprSet) %in% rownames(pdata))]
  exprSet = exprSet[, order(colnames(exprSet))]
  pdata = pdata[order(rownames(pdata)), ]
  
  #### convert probe_ids into gene symbols
  exprSet$probe_id =  as.character(rownames(exprSet))
  if (bioc_annotation_package == "hgu133plus2.db") {probe2symbol_df = toTable(get("hgu133plus2SYMBOL"))}
  if (bioc_annotation_package == "illuminaHumanv4.db") {probe2symbol_df = toTable(get("illuminaHumanv4SYMBOL"))}
  if (bioc_annotation_package == "hugene10sttranscriptcluster.db") {probe2symbol_df = toTable(get("hugene10sttranscriptclusterSYMBOL"))}
  newmatrixdata = exprSet %>% 
    inner_join(probe2symbol_df,by="probe_id") %>% #merge informatio of probe_id
    select(-probe_id) %>% #remove extra column         
    select(symbol, everything()) %>% #re-arrange
    mutate(rowMean = rowMeans(.[grep("GSM", names(.))])) %>% #calculate means
    arrange(desc(rowMean))  %>% #order the means
    distinct(symbol,.keep_all = T) %>% # keep the first symbol information
    select(-rowMean) %>% #remove the new colmun
    tibble::column_to_rownames(colnames(.)[1]) #convert the first column into rownames and remove it  
	
  ### design the new data matrix 
  newmatrixdata = as.data.frame(newmatrixdata)
  newmatrixdata = rbind(pdata$Normal,newmatrixdata)
  rownames(newmatrixdata)[1] = "normal"
  newmatrixdata
}

### GSE10245 = get_microarray_data(geo_accession = "GSE10245",
###                                pdata_file = "git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/GSE10245_pdata.csv",                      
###                                bioc_annotation_package = "hgu133plus2.db")