run_mogsa = function(matrixdata, PathwayFile){

### prepare data 
	preGS = prepMsigDB(file = PathwayFile)
	sup_data = prepSupMoa(matrixdata, geneSets = preGS, minMatch = 1)
	mgsa = mogsa(matrixdata, sup_data, nf = 3,proc.row = "center_ssq1", w.data = "inertia", statis = TRUE)
	mgsa	
}


## 	scores = getmgsa(mgsa, "score")
##	p.mat = getmgsa(mgsa, "p.val")