\name{comb_pval}
\alias{comb_pval}

\title{
Combine p-values by one method
}
\description{
This function is used to compute the combination of P-values via Fisher's method, Stouffer's method or the mean p method.
}
\usage{
comb_pval(Pval.res, method)
}


\arguments{
  \item{Pval.res}{ A matrix with rows representing pathways, and columns representing different methods, each cell contains a p-value. Sometimes it could be output of "run_limma()".}
  \item{method}{ The method is one of Fisher's method, Stouffer's method or the mean p method. Options are: "sumlog", "sumz", "meanp"}
}
\details{
}
\value{
A list or matrix with rows of pathway names and one column of combined p-value.
}

\author{Chengshu Xie <shuxcy@126.com>}
     \examples{
     \dontrun{
	 ### 
	 P.res = readRDS("git@github.com:/mora-lab/benchmarks/blob/master/single-sample/data/examples/P.res.RDS")
	 try = comb_pval(P.res$GSE10245, method = "sumlog")
     }
     }
