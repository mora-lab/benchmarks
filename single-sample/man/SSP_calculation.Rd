\name{SSP_calculation}
\alias{SSP_calculation}

\title{
Calculate the value of sensitivity, specificity and precision 
}
\description{
This function is used to compute the sensitivity, specificity and precision to access the performance of different methods or other. 
Please refer to the Wiki's page to know more(url: https://en.wikipedia.org/wiki/Sensitivity_and_specificity).
}
\usage{
SSP_calculation(Pval.res, target.pathway)
}
\arguments{
   \item{Pval.res}{ Results of P-Values. It's a data matrix with rows representing pathways, and columns representing methods/other features.}
   \item{target.pathway}{ List of pathways that are considered as the significant target pathways in biological process. This could be output of "read_gmt()". 
   Index "1" contains list of all genes in genesets, while index "2" contains names of each genesets}
}
\value{
A list of three results: sensitivity, specificity and precision value.
}

\author{Chengshu Xie <shuxcy@126.com>}
     \examples{
     \dontrun{
	 ### target_COPD = read_gmt("git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/COPD.target.pathway.symbols.gmt")
	 ### Pval.res = readRDS("git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/examples/Pval_res.RDS")
	 ### result = SSP_calculation(Pval.res, target_COPD)
     }
     }
