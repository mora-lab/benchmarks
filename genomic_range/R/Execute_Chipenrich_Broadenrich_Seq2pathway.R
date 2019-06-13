Execute_Chipenrich_Broadenrich_Seq2pathway <- function(){
## Testing individual data in benchmark dataset with each GSA tool package
## Also, since several of the tools don't acknowledge the mitochondrial DNA ("chrMT") entries have to be removed from the BED files.

regenerated_samples <- list()
seq2pathway_results <- list()

for (i in 1:length(ChIPSeqSamples))
{
  regenerated_samples[[i]] <- read_bed(paste("./regen/",paste(eval(parse(text="ChIPSeqSamples[i]")),".bed", sep = ""), sep = ""))
  seq2pathway_results[[i]] <- runseq2pathway(regenerated_samples[[i]], genome = "hg19")
}
saveRDS(seq2pathway_results, file = "./Results/seq2pathway/seq2pathway_results")
rm(seq2pathway_results)


chipenrich_results <- list()
for (i in 1:length(ChIPSeqSamples))
{
  chipenrich_results[[i]] <- chipenrich(peaks = paste("./regen/",paste(eval(parse(text="ChIPSeqSamples[i]")),".bed", sep = ""), sep = ""), out_name = NULL, genesets = c("GOBP", "GOCC", "GOMF", "kegg_pathway"), genome = "hg19", qc_plots = FALSE, n_cores = 1)
}
saveRDS(chipenrich_results, file = "./Results/chipenrich/chipenrich_results")
rm(chipenrich_results)


broadenrich_results <- list()
for (i in 1:length(ChIPSeqSamples))
{
  broadenrich_results[[i]] <- broadenrich(peaks = paste("./regen/",paste(eval(parse(text="ChIPSeqSamples[i]")),".bed", sep = ""), sep = ""), out_name = NULL, genesets = c("GOBP", "GOCC", "GOMF", "kegg_pathway"), genome = "hg19", qc_plots = FALSE, n_cores = 1)
}
saveRDS(broadenrich_results, file = "./Results/broadenrich/broadenrich_results")
rm(broadenrich_results)
}
