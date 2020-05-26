# A collection of R tools for benchmarking single-sample GSA methods
First version: May 25th, 2020<br>
Last review: May 25th, 2020
## What is single-sample GSA?
**S**ingle **S**ample **G**ene **S**et **A**nalysis(**ss-GSA**) is a specific type of Gene Set Analysis, used to calculate each individual sample’s pathway score for comparison among those individuals in normal and disease status. ss-GSA methods are concentrated on individual samples.
## Contents
* The data folder contains the input data objects that used in each workflow. <br>
* The inprocess folder contains workflows which are not able to be used currently. <br>
* **Workflows:**
* The "Benchmark study on single sample gene set analysis tools.ipynb" is under the "inprocess" folder.
* **Tutorials:**
1. The "Tutorial of GSVA using data GSE10245.ipynb" file contains the useage of GSVA packages, using the example data ["GSE10245"](https://github.com/mora-lab/benchmarks/blob/master/single-sample/workflows/data/GSE10245.RDS) in **workflows/data** folder. <br>
2. The "Tutorial of GRAPE using data GSE10245.ipynb" file contains the useage of GRAPE pckages, using the example data ["GSE10245"](https://github.com/mora-lab/benchmarks/blob/master/single-sample/workflows/data/GSE10245.RDS) in **workflows/data** folder. <br>
3. The "Tutorial of pathifier using data GSE10245.ipynb" file contains the useage of pathifier pckages, using the example data ["GSE10245"](https://github.com/mora-lab/benchmarks/blob/master/single-sample/workflows/data/GSE10245.RDS) in **workflows/data** folder. <br>
4. The "Tutorial of mogsa using built-in data.ipynb" file contains the useage of mogsa pckages, using the example data ["GSE10245"](https://github.com/mora-lab/benchmarks/blob/master/single-sample/workflows/data/GSE10245.RDS) in **workflows/data** folder. <br>
5. The "Tutorial of singscore using built-in data.ipynb" file contains the useage of singscore pckages, using the example data ["GSE10245"](https://github.com/mora-lab/benchmarks/blob/master/single-sample/workflows/data/GSE10245.RDS) in **workflows/data** folder. <br>

## How to watch the jupyter notebooks successfully?
1. Turn to the [nbviewer](https://nbviewer.jupyter.org/).
2. Copy the website address of the `.ipynb` file(For example, copy the address of "GRAPE_GSE10245.ipynb": https://github.com/mora-lab/benchmarks/blob/master/single-sample/workflows/GRAPE_GSE10245.ipynb), paste it and click the `Go!` button in the nbviewer page.
## How to run and/or edit the jupyter notebooks?
1. Make sure that you have installed jupyter botebook already, and have added R kernel in it. You could follow the tutorial in the [jupyter home](https://jupyter.org/install).
2. You could try the example dataset directly in the `data` folder and also you could use your own dataset. `Enter` + `Shift` to  run the codes under `code` mode. 
## References
See our paper:<br><br>
XIE, C., JAUHARI, S., MORA, A. (2020), Popularity and performance of bioinformatics software -The case of gene set analysis
