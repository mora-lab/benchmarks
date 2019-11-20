tools_results <- c("chipenrich_results_shredded", "broadenrich_results_shredded","seq2pathway_results_shredded","enrichr_results_shredded","great_results_shredded")
disease_pools <- c("colorectal_cancer_id_pool", "alzheimers_disease_id_pool", "gastric_cancer_id_pool", "prostate_cancer_id_pool")

SnSpPr <- function()
  
{
  tool <- as.integer(readline("Enter the tool index (1: Chipenrich, 2: Broadenrich, 3: Seq2Pathway, 4: Enrichr, 5: GREAT):"))
  sam <- as.integer(readline("Enter the sample index (Refer ChIPSeqMaster):"))
  
  
  ## Classical Sensitivity, Specificity, Precision
  
  for ( d in 1:length(disease_pools))
  {

    true_positives <- list()
    true_negatives_ids <- list()
    false_positives1_ids <- list()
    false_positives2_ids <- list()
    false_positives <- list()
    false_negatives <- list()
    count1 <- 1
    count2 <- 1
    
    ## Tool results' subsets on the basis of statistical significance.
    greater_than_0.05 <- eval(parse(text=(paste0(paste0(tools_results[tool],"$"), ChIPSeqSamples[sam]))))[which(eval(parse(text=(paste0(paste0(tools_results[tool],"$"), ChIPSeqSamples[sam]))))[2] > 0.05),]
    less_than_0.05 <- eval(parse(text=(paste0(paste0(tools_results[tool],"$"), ChIPSeqSamples[sam]))))[which(eval(parse(text=(paste0(paste0(tools_results[tool],"$"), ChIPSeqSamples[sam]))))[2] <= 0.05),]
    true_negatives_ids <- setdiff(greater_than_0.05[[1]], eval(parse(text=disease_pools[d]))) ## All ids that are there in the tool result with p > 0.05 and absent in the disease pool.
    
    false_positives1_ids <- intersect(eval(parse(text=disease_pools[d])),greater_than_0.05[[1]])
    false_positives2_ids <- setdiff(less_than_0.05[[1]],eval(parse(text=disease_pools[d])))
    
    false_positives <- c(false_positives1_ids,false_positives2_ids)
    true_positives <- intersect(less_than_0.05[[1]], eval(parse(text=disease_pools[d])))
    false_negatives <- intersect(greater_than_0.05[[1]], eval(parse(text=disease_pools[d])))
    
    ## Results
    
    library(tidyverse)
    
    cat("True positives for", word(gsub("_", " ", as.character(disease_pools[d])),1:2), ":",length(true_positives),"\n")
    cat("\nTrue negatives for", word(gsub("_", " ", as.character(disease_pools[d])),1:2), ":",length(true_negatives_ids),"\n")
    cat("\nFalse negatives for", word(gsub("_", " ", as.character(disease_pools[d])),1:2), ":",length(false_negatives),"\n")
    cat("\nFalse positives for", word(gsub("_", " ", as.character(disease_pools[d])),1:2), ":",length(false_positives),"\n")
    precision <- length(true_positives)/(length(true_positives)+length(false_positives))
    cat("\nPrecision for", word(gsub("_", " ", as.character(disease_pools[d])),1:2), ":", paste0(as.character(round((precision*100), 4))," %"),"\n")
    sensitivity <- length(true_positives)/(length(true_positives)+length(false_negatives))
    cat("\nSensitivity for", word(gsub("_", " ", as.character(disease_pools[d])),1:2), ":", paste0(as.character(round((sensitivity*100), 4))," %"),"\n")
    specificity <- length(true_negatives_ids)/(length(true_negatives_ids)+length(false_positives))
    cat("\nSpecificity for", word(gsub("_", " ", as.character(disease_pools[d])),1:2), ":", paste0(as.character(round((specificity*100), 4))," %"),"\n\n")
  } 
}