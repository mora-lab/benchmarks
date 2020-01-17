read_file = function(file){
  if(grepl("\\.txt$",file)[1]){ 
    data = read.table(file, header = TRUE, sep = "\t", comment.char = "!")
  } else if(grepl("\\.csv$",file)[1]){ 
    data = read.csv(file, header = TRUE, row.names = 1)
  } else if(grepl("\\.xlsx$",file)[1]){ 
    data = read.xlsx(file, sheet =1, header = TRUE, row.names = 1)
  } else if(grepl("\\.gmt$",file)[1]){ 
    geneSetDB = readLines(file)                                ##read in the gmt file as a vector of lines
    geneSetDB = strsplit(geneSetDB,"\t")                       ##convert from vector of strings to a list
    names(geneSetDB) = sapply(geneSetDB,"[",1)                 ##move the names column as the names of the list
    geneSetDB = lapply(geneSetDB, "[",-1:-2)                   ##remove name and description columns
    data = lapply(geneSetDB, function(x){x[which(x!="")]})##remove empty strings
  } 
  return(data)
}
