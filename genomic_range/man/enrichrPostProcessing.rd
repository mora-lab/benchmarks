\name{enrichrPostprocessing}
\alias{enrichrPostprocessing}

\title{Extracting enrichment terms and p-values from results of Enrichr}

\description{This function loads the results saved by the "enrichrResultsCompilation" function and extracts enrichment IDs from the enrichment terms returned by KEGG and GO in Enrichr. This again is in line to extract meaningful information going forward. In addition, the function also assembles together results from KEGG and GO for each sample.}

\usage{enrichrPostprocessing()}


\note{This function is only to be used after the execution of enrichrResultsCompilation() function.}

\value{The function returns the following to the local media.
\item{enrichrResultsShredded.rds }{Object of consolidated results from Enrichr}}

\author{Shaurya Jauhari}
