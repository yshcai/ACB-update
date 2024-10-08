# install packages
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("AnnotationForge")
BiocManager::install("clusterProfiler", force = T)

# loading packages
library(tidyverse)
library(stringr)
library(KEGGREST)
library(AnnotationForge)
library(clusterProfiler)
library(dplyr)
library(jsonlite)
library(purrr)
library(RCurl)

# String columns are kept as character types
options(stringsAsFactors = F)


# read the result annotated by eggNOG
emapper <- read_tsv("../../../04.Annotation/04_FunctionalAnnotation/04.eggnog/OfOGS.eggNOG.txt",
                    col_names = TRUE)
# Empty strings are replaced with missing values
emapper[emapper==""] <- NA
# gene id and its corresponding description
gene_info <- emapper %>% dplyr::select(
  GID = query, GENENAME = Preferred_name) %>% na.omit()
# Formatted gene id
gene_info$GID <- gsub("\\..*","",gene_info$GID)


# Read the GO information generated by the eggnog-mapper helper function in TBtools-II
gene2go <- read_tsv("../../../04.Annotation/04_FunctionalAnnotation/04.eggnog/MM_b8y1u3of.emapper.annotations.tsv.GO.txt",
                    col_names = c('GID', 'GO'))
gene2go$EVIDENCE <- rep('IDA', nrow(gene2go))
gene2go$GID <- gsub("\\..*","",gene2go$GID)


# Read the KEGG information generated by the eggnog-mapper helper function in TBtools-II
gene2ko <- read_tsv("../../../04.Annotation/04_FunctionalAnnotation/04.eggnog/MM_b8y1u3of.emapper.annotations.tsv.KEGG_Knum.txt",
                    col_names = c('GID', 'KO'))
gene2ko$GID <- gsub("\\..*","",gene2ko$GID)


# read the KO background file generated by a custom python script (ko_background.py)
kegg_back <- read_tsv("../../../04.Annotation/04_FunctionalAnnotation/04.eggnog/ko.background.txt",
                       col_names = c('K_Number', 'K_Name', 
                       'Pathway_ID', 'Pathway_Description', 
                       'KEGG_B_Class_ID', 'KEGG_B_Class_Description',
                       'KEGG_A_Class_ID', 'KEGG_A_Class_Description'))
# pathway id and its corresponding description
pathway2name <- kegg_back[,c(3,4)]
pathway2name <- pathway2name[!duplicated(pathway2name), ]
colnames(pathway2name) <- c('Pathway', 'Description')
# k number and its corresponding pathway id
ko2pathway <- kegg_back[,c(1,3)]
colnames(ko2pathway) <- c('KO', 'Pathway')
# gene id and its corresponding pathway id
gene2pathway <- gene2ko %>% left_join(ko2pathway, by = "KO") %>% dplyr::select(GID, Pathway) %>% na.omit()
gene2pathway <- gene2pathway[!duplicated(gene2pathway), ]
# save
save(gene2pathway, pathway2name, ko2pathway, file = "Ofur.kegg_db.RData")


# Build orgdb for the target species
tax_id = "93504"
genus = "Ostrinia"
species = "furnacalis"
makeOrgPackage(gene_info=gene_info,
               go=gene2go,
               ko=gene2ko,
               pathway=gene2pathway,
               version="0.0.1",  # version
               maintainer = "Enosh <yscai416@163.com>",  # author and e-mail
               author = "Enosh <yscai416@163.com>",
               outputDir = ".",  # output directory
               tax_id=tax_id,  # taxonomy id
               genus=genus,
               species=species,
               goTable="go")
# install orgdb
install.packages("./org.Ofurnacalis.eg.db", repos = NULL, type = "sources")
# loading orgdb
library(org.Ofurnacalis.eg.db)
# view
columns(org.Ofurnacalis.eg.db)
