\name{run_GRAPE}
\alias{run_GRAPE}

\title{
Get Pathway Score Matrix
}
\description{
This function is used to calculate pathway scores of a single pathway of a set of samples relative to the control set of samples.
Please refer to GRAPE page(URL: https://cran.r-project.org/web/packages/GRAPE/index.html)
}
\usage{
run_GRAPE(expData, PathwayList)
}


\arguments{
   \item{expData}{ Output of "get_microarray_data()". Gene expression matrix of all samples. Rows are genes(and the first row is the normal status), columns are samples.}
   \item{PathwayList}{ Output of "read_gmt()". List of pathways. Each pathway is a character vector consisting of gene names.}
}
\value{
A matrix with rows of pathway names and columns of samples, and each cell contains pathway scores.
}

\author{Chengshu Xie <shuxcy@126.com>}
     \examples{
     \dontrun{
	 ## the data input refer tp the result of "get_microarray_data()"
	 ### pathwaylist = read_gmt("git@github.com:/mora-lab/benchmarks/tree/master/single-sample/data/c2.cp.kegg.v7.0.symbols.gmt")
	 ### GSE10245 = get_microarray_data(geo_accession = "GSE10245",
	 ###                                pdata_file = "git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/GSE10245_pdata.csv",                      
	 ###                                bioc_annotation_package = "hgu133plus2.db")
	 ### result.GRAPE_GSE10245 = run_GRAPE(GSE10245, pathwaylist)
     }
     }
