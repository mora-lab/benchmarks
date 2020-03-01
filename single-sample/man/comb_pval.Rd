\name{comb_pval}
\alias{comb_pval}

\title{
Combine p-values by the sum of logs (Fisher's) method
}
\description{
This function is used to Compute the conbination of P-values via Fisher's method.
}
\usage{
comb_pval(Pval.res)
}


\arguments{
  \item{Pval.res}{ A matrix with rows representing pathways, and columns representing different methods, each cell contains a p-value. Sometimes it could be output of "run_limma()".
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
     }
     }
