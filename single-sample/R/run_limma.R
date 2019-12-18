run_limma = function(result_list, GSEdata){
  
  design = list();
  contrast.matrix = list();
  fit = list();
  fit2 = list();
  results = list();
  
  for (i in 1:8){
    ## matrix design
    design[[i]] = model.matrix(~0+factor(GSEdata[[i]][1,], levels=c("0","1")))
    colnames(design[[i]]) = c("D0", "N1")
    # rownames(design) = colnames(result) 
    contrast.matrix[[i]] = makeContrasts(N1-D0, levels=design[[i]])
    fit[[i]] = lmFit(result_list[[i]], design[[i]])
    fit2[[i]] = contrasts.fit(fit[[i]], contrast.matrix[[i]])
    fit2[[i]] = eBayes(fit2[[i]])
    results[[i]] = topTable(fit2[[i]], adjust="BH", n = Inf)
    results[[i]] = as.matrix(results[[i]][order(rownames(results[[i]])),4])
    rownames(results[[i]]) = rownames(result_list[[i]][order(rownames(result_list[[i]])),])
    }
  results
  #write.table(results,paste0("limma_DEG.",contrast,".txt"),quote = F,sep = '\t',row.names = T)
}
