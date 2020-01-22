\name{dataImportClean}
\alias{dataImportClean}

\title{Data importation and refining}

\description{The function will load all the data BED files from a local directory, retrieve the file names and save them to a list "ChIPSeqSamples", and transform the BED files to GRanges objects and save them to a GRangesList "samplesInBED". Finally, these objects are saved as RDS files to the current working directory.}

\usage{dataImportClean(loc)}

\arguments{\item{loc}{ the directory path to the data files}}

\value{\item{samplesInBED.rds}{A GRanges List object of all GRanges data files} \item{ChIPSeqSamples.rds}{List of sample names as data files}}

\note{
The function does not return any values, rather saves the aforementioned objects as files.}

\author{Shaurya Jauhari}

\examples{dataImportClean(loc)}

