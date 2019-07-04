# jupyter notebooks with benchmark workflow

Structuring as follows:
Workflow 1:
* A data package (with the benchmark data),
* A first Jupyter notebook for loading the data package and all the method packages (Enrichr, GREAT, etc), to get ranks per sample,
* Some text files with the ranks computed from GREAT’s website (which must be done manually because there is no R package for this method).

Workflow 2:
* A function to get a rank of gene sets and a list of targets (from Part 1), and count true positives (TP), false positives (FP), true negatives (TN), and false negatives (FN).
* A function to compute values of precision, prioritization, sensitivity, and specificity.
* A function to make box-plots of precision, prioritization, etc., for multiple samples.
* A second Jupyter notebook to read all the ranks per sample (Part 1), and use the three previous functions to get the boxplots for precision, prioritization, sensitivity, and specificity.

Workflow 3:
* A function to add different levels of noise to a ChIP-seq sample.
* A function to make a plot of changes of precision, etc. values, for each amount of added noise (ex. a line plot, with y=precision, x=noise, and each line being a different GSA method).
* A third Jupyter notebook loading a given sample, using the function to add different levels of noise, getting the results for all the method packages, and then using the function to plot.

