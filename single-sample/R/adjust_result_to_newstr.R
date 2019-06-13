###adjusting the structure of the result
adjust_result_to_newstr = function(list_cluster){
  i = 0
  new_result = list()
  a = c()
  for (i in 1:length(list_cluster)) {
    j = 1
    new_result$result.ssgsea = cbind(a, list_cluster[[i]][[j]])
    new_result$result.plage = cbind(a, list_cluster[[i]][[j+1]])
    new_result$result.gsva = cbind(a, list_cluster[[i]][[j+2]])
    new_result$result.zscore = cbind(a, list_cluster[[i]][[j+3]])
    a = list_cluster[[i]][[j]]
  }
  new_result
}

try_H00342 = adjust_result_to_newstr(cluster_H00342)
