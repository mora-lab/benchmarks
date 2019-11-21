########################################################
### function to get new data to be used in"GRAPE"
########################################################
format_input_GRAPE = function(GSEdata) {
  Con = GSEdata$exprdata[,which(GSEdata$pdata[,6]==1)]
  Case = GSEdata$exprdata[,which(GSEdata$pdata[,6]==0)]
  Case = as.data.frame(Case)
  Con = as.data.frame(Con)
  result = list("ControlData" = Con, "CaseData" = Case)
  result
}

### GRAPE_input_GSE10245 = format_input_GRAPE(GSE10245)