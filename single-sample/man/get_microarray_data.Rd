\name{get_microarray_data}
\alias{get_microarray_data}

\title{
Get Microarray Data 
}
\description{
Making use of "GEOquery" package and use "getGEO()" to get microarray data from GEO database.
"get_microarray_data()", is designed to get data and adjust its structure to fill in the format 
of futher use. Please refer to the GEOquery's page in bioconductor(url: http://www.bioconductor.org/packages/release/bioc/html/GEOquery.html).
}
\usage{
get_microarray_data(geo_accession, pdata_file, bioc_annotation_package)
}


\arguments{
  \item{geo_accession}{ The GEO Accession Number, or named GEO series ID}
  \item{pdata_file}{ A character matrix(or table) with raw representing samples and column representing some features of samples, like normal status, and description of samples.}
  \item{bioc_annotation_package}{ The annotation R package, with relation to the platform which is used into the GEO accession number. 
  Here there are three annotation packages inside: "hgu133plus2.db", "illuminaHumanv4.db", "hugene10sttranscriptcluster.db"}
}
\value{
A matrix with first raw representing normal information(1 = Normal, 0 = Disease) and other raws representing genes, and columns representing samples.
}

\author{Chengshu Xie <shuxcy@126.com>}
     \examples{
     \dontrun{
	 ###     GSE10245 = get_microarray_data(geo_accession = "GSE10245",
	 ###                                    pdata_file = "git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/GSE10245_pdata.csv",                      
	 ###                                    bioc_annotation_package = "hgu133plus2.db")
     }
     }
