\name{enrichrResultsCompilation}

\title{Compiling results from Enrichr: GO and KEGG}

\description{Enrichr is a tool woth a web interface, requiring the user to manually curate the results and save them in the local media. Since KEGG pathway database and Gene Ontology (Molecular Function, Cellular Compartment, Biological Process) terms are relevant to our analysis, the user is required to extract these terms from Enrichr. This function helps assembles all the resultant terms into an R object. Only enrichment terms and p-values are stored.}

\usage{enrichrResultsCompilation()}

\details{The function assumes that the results are located in the sub-subfolder "Enrichr" inside the subfolder "results" of the working directory. Evene inside "Enrichr" folder, the results from aforementioned sources have to be saved in separate subfolders namely: "GO_Biological_Process_2018", "GO_Cellular_Component_2018", "GO_Molecular_Function_2018", and "KEGG_2019_Human". The folders have been so named to reflect the contemporary database nomenclature available in Enrichr. Also to note, is that the resultant files for each sample must be named by the sample name only, and should be saved as tab-delimited.}

\value{The function saves the compilation as the following in the Enrichr subfolder.
\item{enrichrGOBPResultsShredded.rds}{Results from GO:BP}
\item{enrichrGOMFResultsShredded.rds}{Results from GO:MF}
\item{enrichrGOCCResultsShredded.rds}{Results from GO:CC
\item{enrichrKEGGResultsShredded.rds}{Results from Enrichr}
}}

\author{Shaurya Jauhari}

\examples{enrichrResultsCompilation()}
