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
run_GRAPE(ctrdata, alldata, PathwayFile)
}


\arguments{
   \item{ctrdata}{Output of "format_input_GRAPE()". Gene expression matrix of control samples. Rows are genes, columns are samples.}
   \item{alldata}{Gene expression matrix of all samples. Rows are genes, columns are samples. Refer to output of "get_microarray_data()". }
   \item{PathwayFile}{ Output of "read_gmt()". List of pathways. Each pathway is a character vector consisting of gene names.}
}
\value{
A matrix with rows of pathway names and columns of samples, and each cell contains pathway scores.
}

\author{Chengshu Xie <shuxcy@126.com>}
     \examples{
     \dontrun{
	 ## the data input refer tp the result of "format_input_GRAPE()"
	 ### pathwaylist = read_gmt("git@github.com:/mora-lab/benchmarks/tree/master/single-sample/data/c2.cp.kegg.v7.0.symbols.gmt")
	 ### GSE10245 = get_microarray_data(geo_accession = "GSE10245",
	 ###                                pdata_file = "git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/GSE10245_pdata.csv",                      
	 ###                                bioc_annotation_package = "hgu133plus2.db")
	 ### GRAPE_input_GSE10245 = format_input_GRAPE(GSE10245)
	 ### result.GRAPE_GSE10245 = run_GRAPE(GRAPE_input_GSE10245$ControlData, GSE10245[-1,], pathwaylist)
     }
     }
