########################################################
#### function to get results of "GRAPE"
########################################################
run_GRAPE = function(refFile, all.data, PathwayFile){

    psmat = makeGRAPE_psMat(refdata, all.data, pathwaylist)
	colnames(psmat) = colnames(all.data)
	psmat
	
}

### result.GRAPE_GSE10245 = run_GRAPE(GSE10245$ControlData, GSE10245$all.data, pathwaylist)
