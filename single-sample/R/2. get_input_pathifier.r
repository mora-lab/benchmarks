####function to get new data to be used in"pathifier"
get_input_pathifier = function(pdata, setentrez){
  
  # Prepare data and parameters 
  # Extract information from binary phenotypes. 1 = Control, 0 = Disease
  normals = as.vector(as.logical(pdata$Normal))
  exp_matrix = as.matrix(setentrez)
  
  # Calculate MIN_STD
  New_exp_matrix = exp_matrix[,as.logical(normals)]
  nsd = apply(New_exp_matrix, 1, sd)
  min_std = quantile(nsd, 0.25)
  
  # Calculate MIN_EXP
  min_exp = quantile(as.vector(exp_matrix), 0.1) # Percentile 10 of data
  
  # Filter low value genes. At least 10% of samples with values over min_exp
  # Set expression levels < MIN_EXP to MIN_EXP
  greater = apply(exp_matrix, 1, function(x) x > min_exp)
  new_greater = apply(greater, 2, mean)
  new_greater = names(new_greater)[new_greater > 0.1]
  exp_matrix = exp_matrix[new_greater,]
  exp_matrix[exp_matrix < min_exp] = min_exp
  
  # Set maximum 5000 genes with more variance
  V = names(sort(apply(exp_matrix, 1, var), decreasing = T))#[1:10000]
  V = V[!is.na(V)]
  exp_matrix = exp_matrix[V,]
  genes = rownames(exp_matrix) # Checking genes
  allgenes = as.vector(rownames(exp_matrix))

  # Generate a list that contains previous data: gene expression, normal status,
  # and name of genes
  DATASET = list()
  DATASET$allgenes = allgenes
  DATASET$normals = normals
  DATASET$data = exp_matrix
  DATASET$min_std = min_std
  DATASET$min_exp = min_exp
  
  result = DATASET
}