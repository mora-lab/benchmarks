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
  
  result
}
