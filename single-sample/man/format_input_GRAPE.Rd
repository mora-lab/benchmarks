\name{format_input_GRAPE}
\alias{format_input_GRAPE}

\title{
Adjust input format used into "run_GRAPE()"
}
\description{
This function is used to separate the whole data into control data and tumor data.
For more details, you could refer to "GRAPE mannual"(http://www.maths.bris.ac.uk/R/web/packages/GRAPE/GRAPE.pdf)
}
\usage{
format_input_GRAPE(expdata)
}


\arguments{
  \item{expdata}{ Output of "get_microarray_data()". A matrix with first raw representing normal information(1 = Normal, 0 = Disease) 
  and other raws representing genes, and columns representing samples.}
}
\value{
A list of contorl data and tumor data.
}

\author{Chengshu Xie <shuxcy@126.com>}
     \examples{
     \dontrun{
	 # if you want to make it run successfully, you should specify the "pdata_file".
     ### GSE10245 = get_microarray_data(geo_accession = "GSE10245",
	 ###                                pdata_file = "git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/GSE10245_pdata.csv",                      
	 ###                                bioc_annotation_package = "hgu133plus2.db")
	 ### GRAPE_input_GSE10245 = format_input_GRAPE(GSE10245)
     }
     }
