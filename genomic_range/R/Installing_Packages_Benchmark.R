Install_Packages_Benchmark <- function(){
  
  ## Installing packages of GSA tools
  source('http://www.bioconductor.org/biocLite.R')
  BiocManager::install('seq2pathway')
  BiocManager::install('enrichR')
  BiocManager::install('broadenrich')
  BiocManager::install('chipenrich')
  
  
  ## Loading Benchmark dataset
  ## Sourcing the compiled gold standard benchmark dataset
  
  install.packages("GSAChIPSeqGold_0.1.1.tar.gz", repos = NULL, type = "source")
  
  
  ## Loading Packages
  
  library(GSAChIPSeqGold)
  library(seq2pathway)
  library(rtracklayer)
  library(chipenrich)
  
  ## For making maximum memory available to R session. 
  memory.size(max = TRUE)
}