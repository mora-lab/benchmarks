### ---------------
### Create: Chengshu Xie
### Date: 2019-01-20 15:43:52
### Email: shuxcy@126.com
### ---------------

comb_pval = function(P.res, method){
  
  com_pvals = c();
  temp = matrix(0,nrow(P.res),1)
  for (i in 1:nrow(P.res)){
    if(method == "sumlog"){ temp[i,1] = sumlog(as.numeric(P.res[i,]))$p}
    if(method == "sumz"){ temp[i,1] = sumz(as.numeric(P.res[i,]))$p}
    if(method == "meanp"){ temp[i,1] = meanp(as.numeric(P.res[i,]))$p}
  }
  temp = as.data.frame(temp)
  # temp$sumlog = sumz(c(P.res$GSVA, P.res$SSGSEA, P.res$PLAGE,P.res$ZSCORE, P.res$PATHIFIER))$p
  colnames(temp) = paste("Comb.", method,sep="")
  rownames(temp) = rownames(P.res)
  return(temp)
}