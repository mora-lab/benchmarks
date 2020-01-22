\name{simulationFalsePositives}
\alias{simulationFalsePositives}

\title{Simulating data for testing robustness against false positives.}

\description{This function adds some random tracks to the original tracks. The idea to create a consolidated genomic track (data frame) by adding together all the regions from the datasets in the benchmark. The following is a master track that holds all the unique tracks from the combinatorial version of the benchmark dataset.}

\usage{simulationFalsePositives()}

\value{\item{allSamplesSimulationAdd}{All samples simulated in enhanced proportions.}}

\author{Shaurya Jauhari}

\note{The function "simulationFalseNegatives" has to be executed prior to this function, for making a data object (allsamples) available for use.}