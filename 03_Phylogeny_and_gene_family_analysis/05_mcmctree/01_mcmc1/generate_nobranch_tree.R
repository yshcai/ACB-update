library(ape)
MLtree <- read.tree("RAxML_bipartitions.all_single_copy_aln.raxml.tree")
MLtree$edge.length <- NULL
MLtree$node.label <- NULL
write.tree(MLtree,"RAxML_bipartitionsNobranch.all_single_copy_aln.raxml.tree")
