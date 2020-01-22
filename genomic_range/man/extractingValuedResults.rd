\name{extractingValuedResults}
\alias{extractingValuedResults}

\title{Extracting enrichment terms and p-values from the results of Chipenrich, Broadenrich, and Seq2pathway tool-runs }

\description{The function load the saved results from Chipenrich, Broadenrich, and Seq2pathway, and will pull out the enrichment terms and the corresponding values of statistical significances. This step is important as we aim to compare intersections of these dat with the enrichment terms of target pathways.}

\usage{extractingValuedResults}

\value{The function returns the following to the local media. \item{seq2pathwayResultsShredded.rds}{seq2pathway results for the given data files} 
\item{chipenrichResultsShredded.rds}{chipenrich results for the given data files}
\item{broadenrichResultsShredded.rds}{broadenrich results for the given data files}}

\author{Shaurya Jauhari}



