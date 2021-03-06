calculateSensitivitySpecificityPrecision <- function(tool)
  {
  forPrecision <- vector("list", length(ChIPSeqSamples))
  forSensitivity <- vector("list", length(ChIPSeqSamples)) 
  forSpecificity <- vector("list", length(ChIPSeqSamples)) 

  ## Classical Sensitivity, Specificity, Precision
  
  for (sam in 1:length(ChIPSeqSamples))
  {
    for (dis in 1:length(diseasePools))
    {
      truePositives <- list()
      trueNegatives <- list()
      falsePositives <- list()
      falseNegatives <- list()
    
    ## Tool results' subsets on the basis of statistical significance.
    greaterThan0.05 <- eval(parse(text=(paste0(paste0(toolsResults[tool],"$"), ChIPSeqSamples[sam]))))[which(eval(parse(text=(paste0(paste0(toolsResults[tool],"$"), ChIPSeqSamples[sam]))))[2] > 0.05),]
    lessThan0.05 <- eval(parse(text=(paste0(paste0(toolsResults[tool],"$"), ChIPSeqSamples[sam]))))[which(eval(parse(text=(paste0(paste0(toolsResults[tool],"$"), ChIPSeqSamples[sam]))))[2] <= 0.05),]
    trueNegatives <- setdiff(greaterThan0.05[[1]], eval(parse(text=diseasePools[dis]))) ## All ids that are there in the tool result with p > 0.05 and absent in the disease pool.
    
    falsePositives <- setdiff(lessThan0.05[[1]],eval(parse(text=diseasePools[dis])))
    truePositives <- intersect(lessThan0.05[[1]], eval(parse(text=diseasePools[dis])))
    falseNegatives <- intersect(greaterThan0.05[[1]], eval(parse(text=diseasePools[dis])))
    
    ## Results
    
    precision <- length(truePositives)/(length(truePositives)+length(falsePositives))
    sensitivity <- length(truePositives)/(length(truePositives)+length(falseNegatives))
    specificity <- length(trueNegatives)/(length(trueNegatives)+length(falsePositives))

    # Store results
    forPrecision[[sam]][dis] <- precision
    forSensitivity[[sam]][dis] <- sensitivity
    forSpecificity[[sam]][dis] <- specificity

    }
  } 
  
  ## Let's return a list for convenience; a list of dataframes.
  masterReturn <- list(listToFrame(forSensitivity), listToFrame(forSpecificity), listToFrame(forPrecision))
  return(masterReturn)
}