### combination of p_values

comb_pval = function(P.res1,P.res2){
 
  com_pvals = c();
  temp = c();
  for(j in 1:ncol(P.res1)){
    for(i in 1:nrow(P.res1)){
        temp[i] = sumlog(c(P.res1[i,j],P.res2[i,j]))$p
        # rownames(temp[i,j]) = rownames(P.res1[i,j])
    }
    com_pvals = cbind(com_pvals,temp)
  }
 # com_pvals = do.call(rbind, temp)
  rownames(com_pvals) = rownames(P.res1)
  colnames(com_pvals) = colnames(P.res1)
  return(com_pvals)
}