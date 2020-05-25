# A collection of R tools for benchmarking single-sample GSA methods
First version: May 25th, 2020<br>
Last review: May 25th, 2020
## What is single-sample GSA?
Single Sample Gene Set Analysis(ss-GSA) is a specific type of Gene Set Analysis, used to calculate each individual sample’s pathway score for comparison among those individuals in normal and disease status. ss-GSA methods are concentrated on individual samples.
## Contents
The **R** folder contains functions that used to manage data format, read `.GMT` files, get microarray data, run each ss-GSA tools and computing sensitivity, specificity and precision(SSP for short). <br>
The **data** folder contains target pathways of each disease, and the phenotype data information of benchmark datasets. <br>
The **man** folder contains descriptions and examples of each R functions. <br>
The **results** folder contains `.RDS` files about scores results and SSP results.  <br>
The **workflows** folder contains the workflow of using each method with the example dataset(here is part data of GSE10245).
## References
See our paper:<br><br>
XIE, C., JAUHARI, S., MORA, A. (2020), Popularity and performance of bioinformatics software -The case of gene set analysis
