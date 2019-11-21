### ---------------
### Create: Chengshu Xie
### Date: 2019-01-20 15:43:52
### Email: shuxcy@126.com
### ---------------

get_microarray_data = function(geo_accession, pdata_file, bioc_annotation_package){  ### make sure of the R annotation package

    ## read phenotype data into R
    phenotype_data = read.table(pdata_file, header=TRUE, row.names = 1)
	phenotype_data = phenotype_data[order(rownames(phenotype_data)), ]
    expression_data = getGEO(geo_accession, destdir = ".", getGPL = FALSE)
    expression_data = exprs(expression_data[[1]])
    expression_data = as.data.frame(expression_data)
    
	### match samples between phenotype_data and expression_data
	expression_data = expression_data[which(colnames(expression_data) %in% rownames(phenotype_data)),]
	expression_data = expression_data[, order(colnames(expression_data))]
	
	#### convert probe ids into 
	expression_data$probe_id = rownames(expression_data)
	if (bioc_annotation_package == "hu6800.db") { probe2symbol_df = toTable(get("hu6800SYMBOL"))}
	if (bioc_annotation_package == "hgu133plus2.db") {probe2symbol_df = toTable(get("hgu133plus2SYMBOL"))}
	if (bioc_annotation_package == "illuminaHumanv4.db") { probe2symbol_df = toTable(get("illuminaHumanv4SYMBOL"))}
	if (bioc_annotation_package == "hugene10sttranscriptcluster.db") { probe2symbol_df = toTable(get("hugene10sttranscriptclusterSYMBOL"))}
	newmatrixdata = expression_data %>% 
                    	inner_join(probe2symbol_df,by="probe_id") %>% #merge informatio of probe_id
						select(-probe_id) %>% #remove extra column         
						select(symbol, everything()) %>% #re-arrange
						mutate(rowMean = rowMeans(.[grep("GSM", names(.))])) %>% #calculate means
						arrange(desc(rowMean))  %>% #order the means
						distinct(symbol,.keep_all = T) %>% # keep the first symbol information
						select(-rowMean) %>% #remove the new colmun
						tibble::column_to_rownames(colnames(.)[1]) #convert the first column into rownames and remove it           
	newmatrixdata = as.data.frame(newmatrixdata)
	result = list("pdata" = phenotype_data, "exprdata" = newmatrixdata)   #### phenotype data and expression data
	result
}

### GSE10245 = get_microarray_data(geo_accession = "GSE10245",
###                                pdata_file = "~/GSE10245_pdata.txt",                      
###                                bioc_annotation_package = "hgu133plus2.db")