### ---------------
### Create: Chengshu Xie
### Date: 2020-02-20 
### Email: shuxcy@126.com
### ---------------

run_individPath <- function(expData, PathwayList, cutoff){
  
  allData  = expData[-1,]
  ### input data
  ControlData <- allData[ , which(expData[1,] == 1)] 
  CaseData <- allData[ , which(expData[1,] == 0)] 
  ControlData  <- as.matrix(ControlData) 
  CaseData <- as.matrix(CaseData)
  
  SampleInfo <- colnames(CaseData);
  NumSample <- length(SampleInfo);
  PathName <- as.matrix(names(PathwayList));
  
  ###---------Identifying Stable gene pair -------###
  print("Identifying stable and reversal intra-pathway gene pairs");
  NumPath <- length(PathwayList);
  NumControl <- ncol(ControlData);
  GeneID <- rownames(ControlData);
  ReversalStat <- NULL ;
  BG.GenePairs <- NULL;
  PathGP <- matrix(0,NumPath,1);
  for( i in 1:NumPath){
    print(paste("Processing ", i, "/", NumPath," : ", PathName[i,1], sep=""));	
    GeneList.tmp =  as.matrix(PathwayList[[i]]);
    InterGene = as.matrix(intersect(GeneList.tmp, GeneID));
    
    if(length(InterGene)>1) {
      Genepairs <- t(combn(InterGene,2));
      Stable.tmp <- NULL;
      Reversal.tmp <- NULL;
      TmpIndex <- matrix(0,nrow(Genepairs),1);
      for (j in 1:nrow(Genepairs)) {
        fra=sum(ControlData[match(Genepairs[j,1],GeneID), -1] > ControlData[match(Genepairs[j,2],GeneID), -1])/NumControl;
        if(fra>cutoff) {
          TmpIndex[j,1]=1; 
        }
        if((1-fra)>cutoff) {
          TmpIndex[j,1]=-1;
        }
      }
      if(sum(abs(TmpIndex))>0) {
        Genepairs <- cbind(Genepairs, TmpIndex);
      }
      if( ncol(Genepairs)>2 ) {
        Stable.tmp <- Genepairs[abs(as.numeric(Genepairs[ ,3]))==1,];
        BG.GenePairs <- unique(rbind(BG.GenePairs,Stable.tmp));
        PathGP[i,1] <- nrow(Stable.tmp);
        
        for (k in 1:nrow(Stable.tmp)){
          loc1 <- match(Stable.tmp[k,1],GeneID);
          loc2 <- match(Stable.tmp[k,2],GeneID);				
          if (Stable.tmp[k,3]==1){
            tmp1 <- CaseData[loc1,] < CaseData[loc2,];
            Reversal.tmp <- rbind(Reversal.tmp,tmp1);			
          }	
          if (Stable.tmp[k,3]==-1){
            tmp2 <- CaseData[loc1,] > CaseData[loc2,];
            Reversal.tmp <- rbind(Reversal.tmp,tmp2);
          }
        }			
        ReversalStat <- rbind(ReversalStat, colSums(Reversal.tmp));
      }
    }
  }
  SRGgenePair.result <- list("ReversalStat" = ReversalStat,
                             "BG.GenePairs" = BG.GenePairs,
                             "PathGP" = PathGP);
  StableGP <- SRGgenePair.result$BG.GenePairs;
  NumStable <- nrow(StableGP);
  ReversalGP <- SRGgenePair.result$ReversalStat;
  PathGP <- SRGgenePair.result$PathGP;	
  
  ###---------Individualized altered pathway -------###
  Result <- NULL;
  for( i in 1:NumSample){
    print(paste("individPath_processing ", i, "/", NumSample," : ", SampleInfo[i], sep=""));
    patient <- CaseData[,i];
    # names(patient) <- CaseData[,1];
    
    Result.tmp <- individPathCal(patient, StableGP, ReversalGP[,i], NumStable, PathGP);
    Result <- cbind(Result,Result.tmp);	
  }
  rownames(Result) <- PathName;
  colnames(Result) <- SampleInfo;	
  result <- as.matrix(Result)
  return(result)
}
individPathCal <- function(CaseData, StableGP, ReversalGP, NumStable, PathGP){
    
    GeneID <-names(CaseData);##
    individPath.result <- NULL;
    Obs.Reversal <- NULL;
    for (k in 1:NumStable){
      loc1 <- match(StableGP[k,1],GeneID);
      loc2 <- match(StableGP[k,2],GeneID);	
      
      if (StableGP[k,3]==1){
        Obs.Reversal[k] <- CaseData[loc1] < CaseData[loc2];
      }
      if(StableGP[k,3]==-1){
        Obs.Reversal[k] <- CaseData[loc1] > CaseData[loc2];
      }
    }
    True.Reversal=sum(Obs.Reversal);
    
    individPath.result <- matrix(1,length(PathGP),1);
    for (j in 1:length(PathGP)) {
      if(ReversalGP[j]>0) {
        individPath.result[j,1]=1-phyper(ReversalGP[j]-1, True.Reversal, NumStable-True.Reversal,PathGP[j]);
      }
    }
    return(individPath.result);
  }

### pathwaylist = read_gmt("git@github.com:/mora-lab/benchmarks/tree/master/single-sample/data/c2.cp.kegg.v7.0.symbols.gmt")
### GSE10245 = get_microarray_data(geo_accession = "GSE10245",
###                                pdata_file = "git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/GSE10245_pdata.csv",                      
###                                bioc_annotation_package = "hgu133plus2.db")
### individPath.result = run_individPath(GSE10245, pathwaylist, cutoff = 0.99)
