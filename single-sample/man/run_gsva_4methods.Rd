\name{run_gsva_4methods}
\alias{run_gsva_4methods}

\title{
Get enrichment scores matrix of 4 methods(GSVA, SSGSEA, PLAGE AND ZSCORE).
}
\description{
This function is used to calculate enrichment scores matrix of 4 methods(GSVA, SSGSEA, PLAGE AND ZSCORE).
The enrichment scores evaluate pathways of a set of samples. 
Please refer to the GSVA's page in bioconductor(url: http://www.bioconductor.org/packages/release/bioc/html/GSVA.html).
}
\usage{
run_gsva_4methods(expData, genesetcollection)
}


\arguments{
   \item{expData}{Data matrix with rows of genes and columns of samples. Refer to output of "get_microarray_data()". }
   \item{genesetcollection}{ List of pathways or "GeneSetCollection" object. Each pathway is a character vector consisting of gene names.}
}
\value{
A list with 4 matrix(there are 4 methods used in the function), and each matrix has samples in column and pathways in row. 
Each cell contains a enrichment score regarding to pathway in each sample.
}

\author{Chengshu Xie <shuxcy@126.com>}
     \examples{
     \dontrun{
	 ###  library(GSEABase)
	 ###  genesetcollection = getGmt("git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/COPD.target.pathway.symbols.gmt", 
	 ###                             geneIdType = SymbolIdentifier())   ### will produce warning but ignore it
	 ###  GSE10245 = get_microarray_data(geo_accession = "GSE10245",
	 ###                                 pdata_file = "git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/GSE10245_pdata.csv",                      
	 ###                                 bioc_annotation_package = "hgu133plus2.db")
	 ###  gsva_4results_GSE10245 = run_gsva_4methods(GSE10245[-1,], genesetcollection)
	 }
	}
