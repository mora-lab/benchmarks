\name{calculatePrioritization}
\alias{calculatePrioritization}

\title{Calculating Prioritization}

\description{This function returns the values for prioritization. Prioritization is one of our comparison metrics that matches each (enrichment term, p-value) pair from the results of each sample to every enrichment term available for every disease, for all diseases. Currently, we have compiled terms for Colorectal Cancer, Gastric Cancer, Prostate Cancer, and Alzheimer's Disease. The results from the enrichment tools are pre-sorted and the idea now is to record what terms intersect. The indices of the ones that do are recorded and the first index (rank one) is acknowledged in calculation of prioritization.}

\usage{calculatePrioritization(tool)}

\arguments{\item{tool}{tool index from the list of tools; 5 in all currently.}

\details{This function also employs another function "listToFrame" that helps convert the list of lists to an annotated data frame of prioritization values for all samples and diseases and also adds a column for median value that is used for plotting the metric. The function also handles errors that may be a result of no match between terms. In such a case, the prioritization is zero.}

\value{\item{forPrioritization}{This is data frame that holds prioritization values for all samples, spanning all given diseases.}}

\author{Shaurya Jauhari}

\examples{calculatePrioritization(1), where 1 is an index representing a disease in the list of diseases.}

\references{{http://dx.doi.org/10.1371/journal.pone.0079217}}

