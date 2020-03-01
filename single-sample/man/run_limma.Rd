\name{run_limma}
\alias{run_limma}

\title{
Find enriched gene sets
}
\description{
This function is used to find the enriched gene sets via linear modeling techniques implemented in "limma" package.
Please refer to the limma's page in bioconductor(url: http://www.bioconductor.org/packages/release/bioc/html/limma.html).
}
\usage{
run_limma(result.score, GSEdata)
}
\arguments{
   \item{result.score}{ A list of enrichment scores or other significant values of several datasets. The list could be changed into one data matrix according to your own dataset.
   Here the list is made up of several datasets, and each datasets contains rows representing pathways, and columns representing samples.}
   \item{GSEdata}{ Output of "get_microarray_data()". Gene expression matrix of all samples. Rows are genes(and the first row is the normal status), columns are samples. }
}
\value{
A list or matrix with rows of pathway names and one column of p-value.
}

\author{Chengshu Xie <shuxcy@126.com>}
     \examples{
     \dontrun{
	 ### GSE10245 = get_microarray_data(geo_accession = "GSE10245",
	 ###                                    pdata_file = "git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/GSE10245_pdata.csv",                      
	 ###                                    bioc_annotation_package = "hgu133plus2.db")
     ### genesetcollection = getGmt("git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/COPD.target.pathway.symbols.gmt", 
	 ###                             geneIdType = SymbolIdentifier())   ### will produce warning but ignore it
	 ### gsva_4results_GSE10245 = run_gsva_4methods(GSE10245[-1,], genesetcollection)
	 ### Pval.plage = run_limma(gsva_4results_GSE10245[[1]], GSE10245)

     }
     }
