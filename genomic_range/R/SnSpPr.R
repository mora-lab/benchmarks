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
  
    ## Iterating through the entire length of tool results and id-pool gives the same impression as usign "intersect" and "setdiff" set-operations, thereby achieving the common objective; just for flavor here.
  
    for (i in 1:nrow(eval(parse(text=(paste0(paste0(tools_results[tool],"$"), ChIPSeqSamples[sam]))))[1]))
      {
        for (l in 1:nrow(eval(parse(text=(paste0(paste0(tools_results[tool],"$"), ChIPSeqSamples[sam]))))[2]))
          {
            for (j in 1:length(eval(parse(text=disease_pools[d]))))
              {
                if (i == j && l <= 0.05)
                  {
                    true_positives[[count1]]<- j
                    count1 <- count1 + 1
                  }
                if (i == j && l > 0.05)
                  {
                    false_negatives[[count2]]<- j
                    count2 <- count2 + 1
                  }
            }
        }
    }
  
    ## Tool results' subsets on the basis of statistical significance.
    greater_than_0.05 <- eval(parse(text=(paste0(paste0(tools_results[tool],"$"), ChIPSeqSamples[sam]))))[which(eval(parse(text=(paste0(paste0(tools_results[tool],"$"), ChIPSeqSamples[sam]))))[2] > 0.05),]
    less_than_0.05 <- eval(parse(text=(paste0(paste0(tools_results[tool],"$"), ChIPSeqSamples[sam]))))[which(eval(parse(text=(paste0(paste0(tools_results[tool],"$"), ChIPSeqSamples[sam]))))[2] <= 0.05),]
    true_negatives_ids <- setdiff(greater_than_0.05[[1]], j) ## All ids that are there in the tool result with p > 0.05 and absent in the disease pool.
  
    false_positives1_ids <- intersect(j,greater_than_0.05[1])
    false_positives2_ids <- setdiff(less_than_0.05[1],j)
  
    false_positives <- c(false_positives1_ids,false_positives2_ids)
  
    ## Results
    cat("\nThe following are the metrics for", as.character(disease_pools[d]),"\n")
    cat("True positives for", as.character(disease_pools[d]), "is",length(true_positives),"\n")
    cat("\nTrue negatives for", as.character(disease_pools[d]), "is",length(true_negatives_ids),"\n")
    cat("\nFalse negatives for", as.character(disease_pools[d]), "is",length(false_negatives),"\n")
    cat("\nFalse positives for", as.character(disease_pools[d]), "is",length(false_positives),"\n")
    precision <- length(true_positives)/(length(true_positives)+length(false_positives))
    cat("\nPrecision(in percentage) for", as.character(disease_pools[d]), "is", precision*100,"\n")
    sensitivity <- length(true_positives)/(length(true_positives)+length(false_negatives))
    cat("\nSensitivity(in percentage) for", as.character(disease_pools[d]), "is", sensitivity*100,"\n")
    cat("\nSurrogate Sensitivity(in percentage) for", as.character(disease_pools[d]), "is", for_surrogate_sensitivity*100,"\n")
    specificity <- length(true_negatives_ids)/(length(true_negatives_ids)+length(false_positives))
    cat("\nSpecificity(in percentage) for", as.character(disease_pools[d]), "is", specificity*100,"\n")
  
  } 
}