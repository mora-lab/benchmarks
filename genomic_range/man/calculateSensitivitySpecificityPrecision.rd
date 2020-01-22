\name{calculateSensitivitySpecificityPrecision}
\alias{calculateSensitivitySpecificityPrecision}

\title{Calculating sensitivity, specificity, and precision for a given tool.
}
\description{The function calculates the values for sensitivity, specificity, and precision following the classical definitions of the same.
}

\usage{
calculateSensitivitySpecificityPrecision(tool)
}

\arguments{\item{tool}{tool index from the list of tools; 5 in all currently.}


\value{\item{masterReturn}{A list of dataframes for sensitivity, specificity, and precision values for all samples, against all diseases.}}


\author{Shaurya Jauhari}

\note{The function employs "listToFrame" function in the background to refine final output.}
