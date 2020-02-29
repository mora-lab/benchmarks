\name{format_input_pathifier}
\alias{format_input_pathifier}

\title{
Adjust input format used into "run_pathifier()"
}
\description{
This function is used to manage format of the data to meet the requirements of "run_pathifier()".
Please refer to the pathifier's page in bioconductor(url: http://www.bioconductor.org/packages/release/bioc/html/pathifier.html).
}
\usage{
format_input_pathifier(expData)
}


\arguments{
  \item{expData}{ Output of "get_microarray_data()". A matrix with first raw representing normal information(1 = Normal, 0 = Disease) 
  and other raws representing genes, and columns representing samples.}
}
\value{
A list of data, including expression data, all genes, samples information, normal status, minimal expression and minimal allowed standard deviation of each gene.
}

\author{Chengshu Xie <shuxcy@126.com>}
     \examples{
     \dontrun{
	 ### GSE10245 = get_microarray_data(geo_accession = "GSE10245",
	 ###                                pdata_file = "git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/GSE10245_pdata.csv",                      
	 ###                                bioc_annotation_package = "hgu133plus2.db")
	 ### pathifier_input_GSE10245 = format_input_pathifier(GSE10245)
     }
     }
