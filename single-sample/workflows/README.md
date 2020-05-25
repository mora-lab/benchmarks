# A collection of R tools for benchmarking single-sample GSA methods
First version: May 25th, 2020<br>
Last review: May 25th, 2020
## What is single-sample GSA?
**S**ingle **S**ample **G**ene **S**et **A**nalysis(**ss-GSA**) is a specific type of Gene Set Analysis, used to calculate each individual sample’s pathway score for comparison among those individuals in normal and disease status. ss-GSA methods are concentrated on individual samples.
## Contents
* The data folder contains the input data objects that used in each workflow. <br>
* The inprocess folder contains workflows which are not able to be used currently. <br>
* The "GSVA_xxx.ipython" file contains the workflow and useage of GSVA packages, the xxx means the example dataset in use. <br>
* The "GRAPE_xxx.ipython" file contains the workflow and useage of GRAPE pckages, the xxx means the example dataset in use. 
## How to run and/or edit the jupyter notebooks?
1. Make sure that you have installed jupyter botebook already, and have added R kernel in it. You could follow the tutorial in the [jupyter home](https://jupyter.org/install).
2. You could try the example dataset directly in the `data` folder and also you could use your own dataset. `Enter` + `Shift` to  run the codes under `code` mode. 
## References
See our paper:<br><br>
XIE, C., JAUHARI, S., MORA, A. (2020), Popularity and performance of bioinformatics software -The case of gene set analysis
