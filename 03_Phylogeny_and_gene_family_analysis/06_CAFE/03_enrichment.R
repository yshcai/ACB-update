library(org.Ofurnacalis.eg.db)
library(AnnotationForge)
library(clusterProfiler)
library(enrichplot)
library(ggplot2)

# loading kegg_info.RData
load(file = "Ofur.kegg_db.RData")

# expanded gene families
# read the gene list
gene_expanded <- read.table("Ofur.expanded.p0.05.significant.genes",
                   header = FALSE, col.names = 'geneid')
# formatted gene id
gene_expanded_list <- gsub('\\..*', '', gene_expanded$geneid)
# remove redundancy
gene_expanded_list <- gene_expanded_list[!duplicated(gene_expanded_list)]


# KEGG enrichment
expanded_kegg <- enricher(gene = gene_expanded_list, 
                          TERM2GENE = gene2pathway[c('Pathway', 'GID')],
                          TERM2NAME = pathway2name[c('Pathway', 'Description')],
                          pvalueCutoff = 1,
                          pAdjustMethod = 'BH',
                          qvalueCutoff = 1)
write.table(expanded_kegg, 
            'Ofur.expanded.p0.05.significant.genes.KEGG.tsv', 
            sep = '\t', row.names = FALSE, quote = FALSE)
expanded_kegg <- pairwise_termsim(expanded_kegg)


# dotplot
expanded_kegg_dot <- dotplot(expanded_kegg, label_format = 50, showCategory = 30)
ggsave(filename = 'Ofur.expanded.p0.05.significant.genes.KEGG.dotplot.pdf', 
       plot = expanded_kegg_dot, width = 11, height = 8.5, dpi = 600)
