heatmap_cluster_gsva = function(adj_result){
  ### Install and library packages
  if (!requireNamespace("BiocManager", quietly = TRUE))
       install.packages("BiocManager")
    BiocManager::install("pheatmap")
    BiocManager::install("RColorBrewer")
  library(pheatmap)
  library(RColorBrewer)
  
  nadj_result = pheatmap(adj_result,
                         scale="row",
                         cluster_row = TRUE,
                         #color = redgreen(75),
                         color = colorRampPalette(c("yellow", "white", "blue"))(50),
                         legend_breaks = -3:3,
                         show_rownames = FALSE,
                         show_colnames = TRUE,
                         fontsize_col = 6,
                         cutree_cols = 6,
                         clustering_method = "ward.D2",
                         clustering_distance_rows = "euclidean")
 
  order_row = nadj_result$tree_row$order   #record the order of rows
  order_col = nadj_result$tree_col$order   #record the order of columns
  datat = data.frame(adj_result[order_row,order_col])   # reorder the raw data according to the order of the heatmap
  datat = data.frame(rownames(datat),datat,check.names =F)  # add rownames into the result dataframe
  result = datat[,-1]
  result
}
