\name{plotMetrics}
\alias{plotMetrics}

\title{Generate ggplots for the given metric}

\description{The function is used to plot the median values returned by the "frameMe" function. The ggplot is a bar plot for the particular metric against all tools in question, i.e. Broadenrich, Chipenrich, Enrichr, GREAT, and Seq2pathway. 
}

\usage{plotMetrics(x, metric)}

\arguments{\item{x}{A dataframe with median values for all samples(for all diseases), under each tool.}
\item{metric}{The comparison metric for which the plot is desired, i.e. sensitivity, specificity, precision, or prioritization.}}

\author{Shaurya Jauhari}

\examples{plotMetrics(df, precision)}