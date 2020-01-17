########################################################
#### function to get results of "GRAPE"
########################################################
run_GRAPE = function(refdata, alldata, PathwayFile){
  
  psmat = makeGRAPE_psMat(refdata, alldata[-1,], pathwaylist);
  colnames(psmat) = colnames(alldata[-1,]);
  psmat
  
}

### result.GRAPE_GSE10245 = run_GRAPE(GSE10245$ControlData, GSE10245$all.data, pathwaylist)
