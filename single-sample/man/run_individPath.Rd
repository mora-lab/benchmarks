\name{run_individPath}
\alias{run_individPath}

\title{
Get 
}
\description{
This function is used to 
}
\usage{
run_individPath(expData, PathwayList, cutoff)
}
\arguments{
   \item{expData}{ Output of "get_microarray_data()". Gene expression matrix of all samples. Rows are genes(and the first row is the normal status), columns are samples. }
   \item{PathwayList}{ Output of "read_gmt()". List of pathways. Each pathway is a character vector consisting of gene names.}
   \item{cutpoff}{ Selection criteria for stable intra-pathway gene pairs. The default setting is 0.99. }
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
	 ### GSE10245 = get_microarray_data(geo_accession = "GSE10245",
	 ###                                pdata_file = "git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/GSE10245_pdata.csv",                      
	 ###                                bioc_annotation_package = "hgu133plus2.db")
	 ### individPath.result = run_individPath(GSE10245, pathwaylist, cutoff = 0.99)

     }
     }
