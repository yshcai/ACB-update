# !/bin/bash
Ofur=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/final_assembly/gapfilling/OFUR.T2T.genome.chr.fasta
Bmor=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/final_assembly/gapfilling/sex_chr/reference_genomes/Bombyx_mori.genome.chr.fa
Cmed=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/final_assembly/gapfilling/sex_chr/reference_genomes/Cnaphalocrocis_medinalis.genome.chr.fa

##### genomic alignment #####
nucmer -t 20 -p Ofur_Bmor $Bmor $Ofur
dnadiff -d Ofur_Bmor.delta -p Ofur_Bmor.delta.dnadiff
less Ofur_Bmor.delta.dnadiff.1coords | cut -f 12,13 | sort -k 1,1 -k 2,2n | uniq -dc | sort -k 1,1nr | less > Ofur_Bmor.delta.dnadiff.1coords.align.list

##### align orthologues from B. mori to the ACB genome #####
blastn -query maker_genes_nucleotide_from_Bmor.fa -task blastn -db OFUR.T2T.genome.chr.fasta -out blastn_maker_genes_nucleotide_from_Bmor.txt -outfmt 6 -max_hsps 1 -max_target_seqs 5 -num_threads 4
tblastn -query maker_genes_protein_from_Bmor.fa -db OFUR.T2T.genome.chr.fasta -out tblastn_maker_genes_protein_from_Bmor.txt -outfmt 6 -max_hsps 1 -max_target_seqs 5 -num_threads 4

##### filter the results from nucmer based on the results of blast #####
head -n 29 Ofur_Bmor.delta.dnadiff.1coords.align.list | awk '{print $2"\t"$3}' | less > Ofur_Bmor.delta.dnadiff.1coords.aligntop29.list
grep -w -f Ofur_Bmor.delta.dnadiff.1coords.aligntop29.list Ofur_Bmor.delta.dnadiff.1coords > Ofur_Bmor.delta.dnadiff.1coords.filter.1coords
less Ofur_Bmor.delta.dnadiff.1coords.filter.1coords | awk -v OFS="\t" '{print $12,$1,$2,$13,$3,$4}' | less > Ofur_Bmor.delta.dnadiff.1coords.filter.1coords.synteny

##### identify sex chromosomes #####
nucmer -t 20 -p Ofur_Cmed $Cmed $Ofur
dnadiff -d Ofur_Cmed.delta -p Ofur_Cmed.delta.dnadiff
less Ofur_Cmed.delta.dnadiff.1coords | cut -f 12,13 | sort -k 1,1 -k 2,2n | uniq -dc | sort -k 1,1nr | less > Ofur_Cmed.delta.dnadiff.1coords.align.list
head -n 31 Ofur_Cmed.delta.dnadiff.1coords.align.list | awk '{print $2"\t"$3}' | less > Ofur_Cmed.delta.dnadiff.1coords.aligntop31.list
grep -w -f Ofur_Cmed.delta.dnadiff.1coords.aligntop31.list Ofur_Cmed.delta.dnadiff.1coords > Ofur_Cmed.delta.dnadiff.1coords.filter.1coords
less Ofur_Cmed.delta.dnadiff.1coords.filter.1coords | awk -v OFS="\t" '{print $12,$1,$2,$13,$3,$4}' | less > Ofur_Cmed.delta.dnadiff.1coords.filter.1coords.synteny

##### visualization by TBtools-II #####
