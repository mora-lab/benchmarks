########################################################
### function to get new data to be used in"GRAPE"
########################################################
format_input_GRAPE = function(GSEdata) {
  Con = GSEdata[-1,][ , which(GSEdata[1,] == 1)]
  Case = GSEdata[-1,][ , which(GSEdata[1,] == 0)]
  Case = as.data.frame(Case)
  Con = as.data.frame(Con)
  result = list("ControlData" = Con, "CaseData" = Case)
  result
}

### GRAPE_input_GSE10245 = format_input_GRAPE(GSE10245)