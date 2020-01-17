########################################################
#### function to get results of "pathifier"
########################################################

run_pathifier = function(new_gsedata, PATHWAYS){
  result = quantify_pathways_deregulation(new_gsedata$data,
                                          new_gsedata$allgenes,
                                          PATHWAYS$gs,
                                          PATHWAYS$pathwaynames,
                                          new_gsedata$normals,
                                          # maximize_stability = T,
                                          attempts = 100,
                                          min_std = new_gsedata$min_std,
                                          min_exp = new_gsedata$min_exp)
  
  result.PDS = t(mapply(FUN = c, result$scores))
  # colnames(result.PDS) = colnames(gsedata)
  result.PDS
}

### pathwaylist = read_gmt("F:/lab_data/3. MSigDB files/c2.cp.kegg.v7.0.symbols.gmt")
### PATHWAYS = list()
### PATHWAYS$gs = pathwaylist
### PATHWAYS$pathwaynames = as.list(names(pathwaylist))
### names(PATHWAYS$pathwaynames) = names(pathwaylist)
### result_pathifier_GSE10245 = run_pathifier(pathifier_input_GSE10245, PATHWAYS)