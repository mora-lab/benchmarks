### ---------------
### Create: Chengshu Xie
### Date: 2019-01-20 15:43:52
### Email: shuxcy@126.com
### ---------------

format_input_pathifier = function(GSEdata){
  
  # Prepare data and parameters 
  # Extract information from binary phenotypes. 1 = Control, 0 = Disease
  normals = as.vector(as.logical(GSEdata[1,]));
  exp_matrix = as.matrix(GSEdata[-1,]);
  
  # samples information
  samples = as.list(colnames(exp_matrix));
  # Calculate MIN_STD
  New_exp_matrix = exp_matrix[,as.logical(normals)];
  nsd = apply(New_exp_matrix, 1, sd);
  min_std = quantile(nsd, 0.25);
  
  # Calculate MIN_EXP
  min_exp = quantile(as.vector(exp_matrix), 0.1); # Percentile 10 of data
  
  # Filter low value genes. At least 10% of samples with values over min_exp
  # Set expression levels < MIN_EXP to MIN_EXP
  greater = apply(exp_matrix, 1, function(x) x > min_exp);
  new_greater = apply(greater, 2, mean);
  new_greater = names(new_greater)[new_greater > 0.1];
  exp_matrix = exp_matrix[new_greater,];
  exp_matrix[exp_matrix < min_exp] = min_exp;
  
  # Set maximum 5000 genes with more variance
  # V = names(sort(apply(exp_matrix, 1, var), decreasing = T))#[1:10000]
  # V = V[!is.na(V)]
  # exp_matrix = exp_matrix[V,]
  allgenes = as.vector(rownames(exp_matrix));
  pathifier_input <- list();
  pathifier_input$data <- exp_matrix;
  pathifier_input$samples <- samples;
  pathifier_input$normals <- normals;
  pathifier_input$min_std <- min_std;
  pathifier_input$min_exp <- min_exp;
  pathifier_input$allgenes <- allgenes;
  pathifier_input
}

### GSE10245 = get_microarray_data(geo_accession = "GSE10245",
###                                pdata_file = "git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/GSE10245_pdata.csv",                      
###                                bioc_annotation_package = "hgu133plus2.db")
### pathifier_input_GSE10245 = format_input_pathifier(GSE10245)