### ---------------
### Create: Chengshu Xie
### Date: 2019-01-20 15:43:52
### Email: shuxcy@126.com
### ---------------

newSSPresult = function(SSP_cal) {
  SSP = c();
  SSP.sen = t(SSP_cal$sensitivity.result)
  SSP.spe = t(SSP_cal$specificity.result)
  SSP.pre = t(SSP_cal$precision.result)
  SSP$Methods = rownames(SSP.sen)
  SSP$Sensitivity = SSP.sen
  SSP$Specificity = SSP.spe
  SSP$Precision = SSP.pre
  return(as.data.frame(SSP))
  
}