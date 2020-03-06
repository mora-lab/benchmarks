### ---------------
### Create: Chengshu Xie
### Date: 2019-01-20 15:43:52
### Email: shuxcy@126.com
### ---------------

comb_pval = function(Pval.res){
  
  com_pvals = c() 
  temp = c() 
  for(j in 1:length(Pval.res){
	### use methods in "metap"
	temp[[j]]= sumlog(c(Pval.res[j,]))$p
      # rownames(temp[i,j]) = rownames(P.res1[i,j])
  }
  comb_result = as.data.frame(temp)
  rownames(comb_result) = rownames(Pval.res) 
  colnames(comb_result) = "comb_pvalue"
  return(comb_result)
}

