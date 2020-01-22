\name{greatResultsCompilation}
\alias{greatResultsCompilation}


\title{Compiling and transforming results from GREAT}

\description{The results from GREAT include enrichment statements and not the enrichment IDs as GO:xxxxx or hsaxxxxx. This transformation is essential from the perpective of the disease pools that have been manually curated. The pools have enrichment terms that are in the form of IDs. To acheive this, "GO.db" library is sourced, a GO terms database is temporarily constructed, and the enrichment results from GREAT are matched with this database. Finally, we have the IDs in lieu of statements.}

\usage{greatResultsCompilation()}

\note{The function assumes that the results are placed inside the sub-subfolder "GREAT" in the subfolder "results". Also, as before, the individual resultant files are named after each sample such that the sample names are relatable with the ones in the "ChIPSeqSamples" object.}

\value{\item{greatResultsShredded.rds }{Consolidated results from GREAT}}

\author{Shaurya Jauhari}
