### ---------------
### Create: Chengshu Xie
### Date: 2019-01-20 15:43:52
### Email: shuxcy@126.com
### ---------------

SSP_calculation = function(Pval.res, target.pathway){
  
  cond_below_0.05 = c() 
  cond_over_0.05 = c() 
  
  true_positives = list() 
  true_positives_data = c() 
  false_negatives = c() 
  false_negatives_data = c() 
  true_negatives_ids = list() 
  false_positives1_ids = list() 
  false_positives2_ids = list() 
  false_positives = list() 
  
  greater_than_0.05 = c() 
  less_than_0.05 = c() 
  true_negatives_ids = c() 
  false_positives = c() 
  sensitivity = c() 
  specificity = c() 
  precision = c() 
  
  sensitivity_result = c() 
  specificity_result = c() 
  precision_result = c() 
  
  for (i in 1:ncol(Pval.res)) {
    
    cond_below_0.05[[i]] = rownames(Pval.res[which(Pval.res[,i] <= 0.05),]) %in% toupper(names(target.pathway))
    cond_over_0.05[[i]] = rownames(Pval.res[which(Pval.res[,i] > 0.05),]) %in% toupper(names(target.pathway))
    
    true_positives_data  = Pval.res[which(cond_below_0.05[[i]]),]
    if(class(true_positives_data) == "matrix"){ true_positives = as.numeric(length(true_positives_data[,i])) }
    false_negatives_data  = Pval.res[which(cond_over_0.05[[i]]),]
    if(class(false_negatives_data) == "matrix"){ false_negatives = as.numeric(length(false_negatives_data[,i])) }
    if(class(false_negatives_data) == "numeric"){ false_negatives = 1 }
    
    ## Tool results' subsets on the basis of statistical significance.
    greater_than_0.05[[i]] = as.data.frame(Pval.res[which(Pval.res[,i] > 0.05), i]) 
    less_than_0.05[[i]] = as.data.frame(Pval.res[which(Pval.res[,i] <= 0.05),i]) 
    true_negatives_ids[[i]] = setdiff(rownames(greater_than_0.05[[i]]), names(target.pathway))  ## All ids that are there in the tool result with p > 0.05 and absent in the disease pool.
    
    false_positives1_ids = intersect(rownames(greater_than_0.05[[i]]), names(target.pathway)) 
    false_positives2_ids = setdiff(rownames(less_than_0.05[[i]]), names(target.pathway)) 
    false_positives[[i]] = c(false_positives1_ids,false_positives2_ids) 
    
    sensitivity[[i]] = true_positives/(true_positives + false_negatives) 
    specificity[[i]] = length(true_negatives_ids[[i]])/(length(true_negatives_ids[[i]]) + length(false_positives[[i]])) 
    precision[[i]] = true_positives/(true_positives + length(false_positives[[i]]))
  }
  
  sensitivity.re = data.frame(t(sapply(sensitivity,c)))
  specificity.re = data.frame(t(sapply(specificity,c)))
  precision.re = data.frame(t(sapply(precision,c)))
  colnames(sensitivity.re) = colnames(specificity.re) = colnames(precision.re) = colnames(Pval.res)
  
  result = list("sensitivity.result" = sensitivity.re, 
                "specificity.result" = specificity.re,
                "precision.result" = precision.re)
  return(result)
}


