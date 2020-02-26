\name{run_pathifier}
\alias{run_pathifier}

\title{
Get quantify deregulation of pathways score matrix
}
\description{
This function is used to infer pathway deregulation scores for each tumor sample on the basis of expression data.
Please refer to the pathifier's page in bioconductor(url: http://www.bioconductor.org/packages/release/bioc/html/pathifier.html).
}
\usage{
run_pathifier(new_gsedata, PATHWAYS)
}
\arguments{
   \item{new_gsedata}{ Output of "format_input_pathifier()". It's a list of data containing information of expression data matrix, all samples' names,
   all genes, normal status, minimal expression and minimal allowed standard deviation. In expression data matrix, the rows are genes, and the columns are samples.}
   \item{PATHWAYS}{List of pathways. Index "1" contains list of all genes in genesets, while index "2" contains names of each genesets}
}
\value{
A matrix with rows of pathway names and columns of samples, and each cell contains pathway scores.
}

\author{Chengshu Xie <shuxcy@126.com>}
     \examples{
     \dontrun{
	 ### download file in MSigDB(https://www.gsea-msigdb.org/gsea/msigdb/download_file.jsp?filePath=/msigdb/release/7.0/c2.cp.kegg.v7.0.symbols.gmt)
	 ### or 
	 ### pathwaylist = read_gmt("git@github.com:/mora-lab/benchmarks/tree/master/single-sample/data/c2.cp.kegg.v7.0.symbols.gmt")
	 ### PATHWAYS = list()
	 ### PATHWAYS$gs = pathwaylist
	 ### PATHWAYS$pathwaynames = as.list(names(pathwaylist))
	 ### names(PATHWAYS$pathwaynames) = names(pathwaylist)
	 ### How the input data is created, you could check in "format_input_pathifier()"
	 ### GSE10245 = get_microarray_data(geo_accession = "GSE10245",
	 ###                                pdata_file = "git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/GSE10245_pdata.csv",                      
	 ###                                bioc_annotation_package = "hgu133plus2.db")
	 ### pathifier_input_GSE10245 = format_input_pathifier(GSE10245)
	 ### result_pathifier_GSE10245 = run_pathifier(pathifier_input_GSE10245, PATHWAYS)
     }
     }
