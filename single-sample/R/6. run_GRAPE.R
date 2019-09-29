run_GRAPE = function(refFile, all.data, PathwayFile){

    psmat = makeGRAPE_psMat(refdata, all.data, pathwaylist)
	colnames(psmat) = colnames(all.data)
	psmat
	
}
