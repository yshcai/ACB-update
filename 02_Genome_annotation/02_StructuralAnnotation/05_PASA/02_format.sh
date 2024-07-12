# !/bin/bash
genome=/share/home/nxy1hj2cys/hifi/t2t_of/3.Chromosome/Ostrinia_furnacalis_genome.fa

##### format gff3 updated by PASA #####
python3 PASA_GFF_Rename.py blat.Ofur_mydb_pasa.sqlite.gene_structures_post_PASA_updates.1214479.gff3 OfOGS Ofur.pasa_updates.gff3

##### get fasta file #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate rnaseq
gffread Ofur.pasa_updates.gff3 -g $genome -w Ofur.pasa_updates.exon.fa -x Ofur.pasa_updates.cds.fa -y Ofur.pasa_updates.pep.fa

##### format fasta file #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate seqkit
seqkit sort -w 0 -n -N -w 0 Ofur.pasa_updates.exon.fa -o Ostrinia_furnacalis.exon.fa
seqkit sort -w 0 -n -N -w 0 Ofur.pasa_updates.cds.fa -o Ostrinia_furnacalis.cds.fa
seqkit sort -w 0 -n -N -w 0 Ofur.pasa_updates.pep.fa -o Ostrinia_furnacalis.pep.fa
cp Ofur.pasa_updates.gff3 Ostrinia_furnacalis.gff3

##### get the longest sequence #####
python3 get_longest_seq.py Ostrinia_furnacalis.pep.fa Ostrinia_furnacalis.cds.fa Ostrinia_furnacalis.exon.fa Ostrinia_furnacalis.gff3
