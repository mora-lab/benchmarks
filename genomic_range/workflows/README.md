# Benchmark workflows for genomic-range GSA methods
First version: May 25th, 2020<br>
Last review: June 9th, 2020
## What is genomic-range GSA?
A genomic-range GSA is a process of seeking functional enrichment for the genomic regions. This goes a tier deeper than mapping genes to pathways, and we now map genomic regions to genes and then to pathways. Typically the results from **Gene Ontology (GO)** and **Kyoto Encyclopedia of Genes and Genomes (KEGG)** are sought for the same.<br>
## Contents
The "Overall_Workflow" file is the jupyter notebook containing the overall workflow of the comparison analysis for the enrichment tools for genomic regions. <br>
## How to run and/or edit the jupyter notebooks?
A jupyter notebook could be run as a terminal command in any of Linux, Mac, or Windows operating systems, with a valid python installation. For details on installation, follow the [link](https://jupyter.org/install), and [link](https://jupyter.readthedocs.io/en/latest/running.html#running) for execution. Please ensure that the R kernel is configured to work with the notebook as the current code is written in the R language; details available [here](https://irkernel.github.io/installation/).<br>
Alternatively, if the case is to view a jupyter notebook hosted on a GitHub page, the same can be realized via [nbviewer](https://nbviewer.jupyter.org/).<br>
P.S. Note that this jupyter notebook might run into execution errors due to larger memory dependencies. It is advisable to run the notebook with an increased *iopub data rate*, as below. Alternatively, it is also feasible to execute this notebook on an optimum multi-core system configuration with several memory blocks. For reference, a memory error occurred while compiling results on this notebook on a 32-bit RAM equipped, quad-core iMac.    

```
jupyter notebook --NotebookApp.iopub_data_rate_limit=10000000000
```
## References
See our papers:<br><br>
XIE, C., JAUHARI, S., MORA, A. (2020), Popularity and performance of bioinformatics software -The case of gene set analysis <br>
MORA, A. (2019), Gene set analysis methods for the functional interpretation of non-mRNA data -Genomic range and ncRNA data, Briefings in Bioinformatics