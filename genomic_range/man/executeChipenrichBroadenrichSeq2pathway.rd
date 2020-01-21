\name{executeChipenrichBroadenrichSeq2pathway}

\title{Execution of Chipenrich, Broadenrich, and Seq2pathway tools}

\description{The function will execute the three tools, Seq2pathway, Chipenrich, and Broadenrich 
on the given data files from the benchmark dataset, and return the results as RDS objects that are 
list of resultant dataframes for each sample. The list is named as per the samples for convenient
access. The current version of the pipeline is valid for hg19 genome only.}

\usage{executeChipenrichBroadenrichSeq2pathway(loc)}

\arguments{\item{loc}{the directory path to the data files}}

\value{The function returns the following to the local media. \item{seq2pathwayResults.rds}{seq2pathway results for the given data files} 
\item{chipenrichResults.rds}{chipenrich results for the given data files}
\item{broadenrichResults.rds}{broadenrich results for the given data files}}

\details{The function houses three subfunctions for each tool respectively, with the defined parameters as illustrated in the Examples section below.
Each of these tool runs shall create a sub-subfolder(by it's own name) inside the "results" subfolder, to store the results as a list with appropriate sample names.}

\author{Shaurya Jauhari}

\examples{
## Main Function

executeChipenrichBroadenrichSeq2pathway(loc)

## Sub-Functions
### Seq2pathway

seq2pathwayRun <- function(x){
  results <- list()
  results [[i]] <- runseq2pathway(x, genome = "hg19")
  return(results)
}


### Chipenrich

chipenrichRun <- function(x){
  results <- list()
  results [[i]] <- chipenrich(peaks = x, out_name = NULL, 
  genesets = c("GOBP", "GOCC", "GOMF", "kegg_pathway"), 
  genome = "hg19", qc_plots = FALSE, n_cores = 1)
  return(results)
}


### Broadenrich

broadenrichRun <- function(x){
  results <- list()
  results [[i]] <- broadenrich(peaks = x, out_name = NULL, 
  genesets = c("GOBP", "GOCC", "GOMF", "kegg_pathway"), 
  genome = "hg19", qc_plots = FALSE, n_cores = 1)
  return(results)
}
}

\references{
{Seq2pathway(https://www.bioconductor.org/packages/release/bioc/html/seq2pathway.html)}
{Chipenrich(https://bioconductor.org/packages/release/bioc/html/chipenrich.html)}
{Broadenrich(https://rdrr.io/bioc/chipenrich/man/broadenrich.html)}
}


