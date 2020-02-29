### ---------------
### Create: Chengshu Xie
### Date: 2019-01-20 15:43:52
### Email: shuxcy@126.com
### ---------------

read_gmt = function(file){
  if(!grepl("\\.gmt$",file)[1]){stop("Pathway information must be a .gmt file")}  
  geneSet = readLines(file)                                     ##read in the gmt file as a vector of lines
  geneSet = strsplit(geneSet,"\t")                            ##convert from vector of strings to a list
  names(geneSet) = sapply(geneSet,"[",1)                      ##move the names column as the names of the list
  geneSet = lapply(geneSet, "[",-1:-2)                        ##remove name and description columns
  geneSet = lapply(geneSet, function(x){x[which(x!="")]})     ##remove empty strings

  ### Sort the pathway, pathway with more genes comes first.
  geneSet.tmp = lengths(geneSet)
  geneSet.sort = sort(geneSet.tmp, decreasing = TRUE)
  newGS = list()
  for (i in 1:length(geneSet)){
      newGS[i] = geneSet[names(geneSet.sort)[i]]
      names(newGS)[i] = names(geneSet.sort)[i]
  }    
  return(newGS)
   
}
### COPD_target_pathway = read_gmt("git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/COPD.target.pathway.symbols.gmt")
