Plotting_Comparison_Metrics <- function(){
  tryCatch({
    Pr <- as.character(readline("Enter the path of the prioritization file:"))
    SSn <- as.character(readline("Enter the path of the surrogate sensitivity file:"))
    Sn <- as.character(readline("Enter the path of the sensitivity file:"))
    Sp <- as.character(readline("Enter the path of the specificity file:"))
    Pn <- as.character(readline("Enter the path of the precision file:"))
  }, 
  
  # warning = function(w) {
  #   warning-handler-code
  # }, 
  
  error = function(e) {
    print("The file doesn't exist.")
  }, 
  
  finally = {
    
    ## Prioritization Plot | Import the score table from file.
    
    prioritization_score_table <- read.table(Pr, sep = "\t", header = TRUE, quote = "")
    #jpeg(file="Prioritization.jpeg")
    prioritization_score_table <- prioritization_score_table[,c(5,10,15,20)]
    boxplot(prioritization_score_table, ylab = "Prioritization", xlab = "Enrichment Method",col = c("salmon","tan","khaki","lavender"), boxwex = 0.1, ylim = c(0,100), names = c("Chipenrich", "Broadenrich","Seq2pathway", "Enrichr"))
    abline(prioritization_score_table , h=50, col="red")
    #dev.off()
    
    
    ## (Surrogate) Sensitivity Plot | Import the score table from file.
    
    surrogate_sensitivity_table <- read.table(SSn, sep = "\t", header = TRUE, quote = "")
    #jpeg(file="Surrogate_Sensitivity.jpeg")
    surrogate_sensitivity_table <- surrogate_sensitivity_table[,c(5,10,15,20)]
    boxplot(surrogate_sensitivity_table, ylab = "Sensitivity (P-values of Target Pathways)", xlab = "Enrichment Method",col = c("salmon","tan","khaki","lavender"), boxwex = 0.1, ylim = c(0,1), names = c("Chipenrich", "Broadenrich","Seq2pathway","Enrichr"))
    abline(surrogate_sensitivity_table, h=0.5, col="red")
    #dev.off()
    
    
    ## Sensitivity Plot | Import the score table from file.
    
    sensitivity_table <- read.table(Sn, sep = "\t", header = TRUE, quote = "")
    #jpeg(file="Sensitivity.jpeg")
    sensitivity_table <- sensitivity_table[,c(5,10,15,20)]
    boxplot(sensitivity_table, ylab = "Sensitivity", xlab = "Enrichment Method",col = c("salmon","tan","khaki","lavender"), boxwex = 0.1, ylim = c(0,100), names = c("Chipenrich","Broadenrich","Seq2pathway","Enrichr"))
    abline(sensitivity_table, h=50, col="red")
    #dev.off()
    
    
    ## Specificity Plot | Import the score table from file.
    
    specificity_table <- read.table(Sp, sep = "\t", header = TRUE, quote = "")
    #jpeg(file="Specificity.jpeg")
    specificity_table <- specificity_table[,c(5,10,15,20)]
    boxplot(specificity_table, ylab = "Specificity", xlab = "Enrichment Method",col = c("salmon","tan","khaki","lavender"), boxwex = 0.1, ylim = c(0,100), names = c("Chipenrich","Broadenrich","Seq2pathway","Enrichr"))
    abline(specificity_table, h=50, col="red")
    #dev.off()
    
    
    ## Precision Plot | Import the score table from file.
    
    precision_table <- read.table(Pn, sep = "\t", header = TRUE, quote = "")
    #jpeg(file="Precision.jpeg")
    precision_table <- precision_table[,c(5,10,15,20)]
    boxplot(precision_table, ylab = "Precision", xlab = "Enrichment Method",col = c("salmon","tan","khaki","lavender"), boxwex = 0.1, ylim = c(0,3), names = c("Chipenrich","Broadenrich","Seq2pathway","Enrichr"))
    abline(precision_table, h=0.5, col="red")
    #dev.off()
  })}