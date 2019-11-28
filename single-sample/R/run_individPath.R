SRGgenePair = function(ControlData, CaseData, PathData, cutoff){
  
  NumPath = nrow(PathData);
  NumControl = ncol(ControlData);
  GeneID = rownames(CaseData);
  ReversalStat = NULL ;
  BG.GenePairs = NULL;
  PathGP = matrix(0,NumPath,1);
  for( i in 1:NumPath){
    print(paste("Processing ", i, "/", NumPath," : ", PathData[i,1], sep=""));	
    tmp = t(PathData[i,]);
    GeneList.tmp = tmp[-1];
    GeneList = as.numeric(GeneList.tmp[!is.na(GeneList.tmp)]);
    InterGene = as.matrix(intersect(GeneList, GeneID));
    
    if(length(InterGene)>1) {
      Genepairs = t(combn(InterGene,2));
      Stable.tmp = NULL;
      Reversal.tmp = NULL;
      TmpIndex = matrix(0,nrow(Genepairs),1);
      for (j in 1:nrow(Genepairs)) {
        fra = sum(ControlData[match(Genepairs[j,1],GeneID), ] > ControlData[match(Genepairs[j,2],GeneID), ])/NumControl;
        if(fra>cutoff) {
          TmpIndex[j,1]=1; 
        }
        if((1-fra)>cutoff) {
          TmpIndex[j,1]=-1; 
        }
      }
      if(sum(abs(TmpIndex))>0) {
        Genepairs = cbind(Genepairs, TmpIndex);
      }
      if( ncol(Genepairs)>2 ) {
        Stable.tmp = Genepairs[abs(as.numeric(Genepairs[ ,3]))==1,];
        BG.GenePairs = unique(rbind(BG.GenePairs,Stable.tmp));
        PathGP[i,1] = nrow(Stable.tmp);
        
        
        for (k in 1:nrow(Stable.tmp)){
          loc1 = match(Stable.tmp[k,1],GeneID);
          loc2 = match(Stable.tmp[k,2],GeneID);				
          if (Stable.tmp[k,3]==1){
            tmp1 = CaseData[loc1, ] < CaseData[loc2, ];
            Reversal.tmp = rbind(Reversal.tmp,tmp1);					
          }	
          if (Stable.tmp[k,3]==-1){
            tmp2 = CaseData[loc1, ] > CaseData[loc2, ];
            Reversal.tmp = rbind(Reversal.tmp,tmp2);
          }	
        }			
        ReversalStat = rbind(ReversalStat, colSums(Reversal.tmp));
      }
    }
  }
  SRGgenePair.result =list(ReversalStat,BG.GenePairs,PathGP);
  names(SRGgenePair.result) = c("ReversalStat", "BG.GenePairs" ,"PathGP");
  return (SRGgenePair.result);
}

individPathCal = function(CaseData, StableGP, ReversalGP, NumStable, PathGP){
  
  GeneID = rownames(CaseData);##
  individPath.result = NULL;
  Obs.Reversal = NULL;
  for (k in 1:NumStable){
    loc1 = match(StableGP[k,1],GeneID);
    loc2 = match(StableGP[k,2],GeneID);	
    
    if (StableGP[k,3]==1){
      Obs.Reversal[k] = CaseData[loc1] < CaseData[loc2];
    }
    if(StableGP[k,3]==-1){
      Obs.Reversal[k] = CaseData[loc1] > CaseData[loc2];
    }
  }
  True.Reversal = sum(Obs.Reversal);
  
  individPath.result = matrix(1,length(PathGP),1);
  for (j in 1:length(PathGP)) {
    if(ReversalGP[j]>0) {
      individPath.result[j,1]=1-phyper(ReversalGP[j]-1, True.Reversal, NumStable-True.Reversal,PathGP[j]);
    }
  }
  return(individPath.result);
}


run_individPath = function(tumordata, controldata, PathwayFile, cutoff){
  
  # ControlData = as.matrix(read.table(refFile, header=T, sep="\t"));
  # CaseData = as.matrix(read.table(tumorFile, header=T, sep="\t"));
  
  ControlData = as.matrix(controldata);
  CaseData = as.matrix(tumordata);
  SampleInfo = colnames(CaseData);
  NumSample = length(SampleInfo);
  
  if (nrow(CaseData)!=nrow(ControlData)){
    stop("tumorFile and refFile must have the same number of rows!\n");
  }
  
  if (is.na(PathwayFile)){
    stop("Please input pathway data!\n");
  }	
  PathData = read.table(PathwayFile, header=F,sep="\t",fill=T);
  PathName = as.matrix(PathData[,1]);
  
  ###---------Identifying Stable gene pair -------###
  print("Identifying stable and reversal intra-pathway gene pairs");
  GP.result = SRGgenePair(ControlData, CaseData, PathData, cutoff);
  StableGP = GP.result$BG.GenePairs;
  NumStable = nrow(StableGP);
  ReversalGP = GP.result$ReversalStat;
  PathGP = GP.result$PathGP;	
  
  ###---------Individualized altered pathway -------###
  Result = NULL;
  AD.result = NULL;
  for( i in 1:NumSample){
    print(paste("individPath_processing ", i, "/", NumSample," : ", SampleInfo[i], sep=""));
    patient = CaseData[,i]
    names(patient) = rownames(CaseData)
    
    Result.tmp = individPathCal (patient, StableGP, ReversalGP[,i], NumStable, PathGP);
    Result = cbind(Result,Result.tmp);	
    AD.p = as.matrix(as.character(p.adjust(Result.tmp, "BH")))
    AD.result = cbind(AD.result,AD.p);
  }
  Last.Result = cbind( PathName, Result);
  Last.ADResult = cbind( PathName, AD.result);	
  
  colnames(Last.Result)[2:(NumSample+1)] = SampleInfo;	
  colnames(Last.Result)[1] = "PathwayID";
  colnames(Last.ADResult)[2:(NumSample+1)] = SampleInfo;	
  colnames(Last.ADResult)[1] = "PathwayID";
  
  result = list("BH_result" = as.data.frame(Last.Result), "PValue_result" = as.data.frame(Last.ADResult))
  result
}

