\name{listToFrame}
\alias{listToFrame}

\title{Converting list of lists to a annotated data frame}

\description{The function accepts a list of lists, that is a list of samples where each list again holds list of comaprison metric terms for all diseases in order.}

\usage{
listToFrame(x)
}

\arguments{
  \item{x}{list of lists of comparison metric values
}


\value{\item{finalFrame}{Annotated data frame with appropriate column names (disease names), and additonal columns of target-pathway specific values and sample names.}}


\author{Shaurya Jauhari}

\note{This function is only workable for the current context of metric values.}
