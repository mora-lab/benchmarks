\name{simulationFalseNegatives}
\alias{simulationFalseNegatives}

\title{Simulating data for testing robustness against false negatives.}

\description{The function breaks down lengths of child tracks as distinct percentages of the parent track. We have assumed percentages less than 50 because higher order deletions could significantly hamper the outputs.So, proportions of 10, 20, 30, 40, and 50 percents are best suited.}

\usage{simulationFalseNegatives()}

\details{Five entries are created against each entry of all samples' data files, i.e. 5 different tracks from every dataset track abiding 10, 20, 30, 40, and 50 percent reductions in the number of rows. When the original dataset is pruned by certain proportions, the enrichment results are likely to show some discrepancy in results, i.e. some genes must not be present as the regions have been omitted. If the genes are still present, in comparison to the original dataset enrichment results, this will highlight the case for False Negative genes.}

\value{\item{simulatedAllSamples}{All samples simulated in reduced proportions.}}

\author{Shaurya Jauhari}

\note{False negatives could be deduced with the reduced instances of genomic regions. To make the study more viable, we are considering five different proportions of reductions.
P.S. The objects "samplesInBED" and "ChIPSeqSamples" have to be made available prior to executing this function.}