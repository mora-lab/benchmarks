### ---------------
### Create: Chengshu Xie
### Date: 2019-01-20 15:43:52
### Email: shuxcy@126.com
### ---------------

run_GRAPE = function(expData, PathwayList){
    
    ### divide the data into two parts
    ConData = expData[-1,][ , which(expData[1,] == 1)] 
    ConData = as.matrix(ConData) 
    
    psmat = makeGRAPE_psMat(ConData, expData[-1,], PathwayList) 
    colnames(psmat) = colnames(expData[-1,]) 
    psmat
  
}

### result.GRAPE_GSE10245 = run_GRAPE(GSE10245, PathwayList)
