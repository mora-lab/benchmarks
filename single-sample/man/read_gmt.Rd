\name{read_gmt}
\alias{read_gmt}

\title{
Read GMT Files
}
\description{
This function is used to read and parse information from the MSigDB's .gmt files. Pathway information will be returned as a list of gene sets.
}
\usage{
read_gmt(file)
}


\arguments{
  \item{file}{ The .gmt file to be read}
}
\details{
The .gmt format is a tab-delimited list of gene sets, where each line is a separate gene set. 
The first column must specify the name of the gene set, and the second column is used for a short description (which this function discards).
Please refer to the Broad Institute's Data Format's page (url: http://www.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats).
}
\value{
A list with each index representing a gene set.
}

\author{Chengshu Xie <shuxcy@126.com>}
     \examples{
     \dontrun{
	 ### COPD_target_pathway = read.gmt("git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/COPD.target.pathway.symbols.gmt")
     }
     }
