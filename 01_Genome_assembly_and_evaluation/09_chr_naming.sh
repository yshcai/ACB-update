# !/bin/bash
Ofur=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/final_assembly/gapfilling/OFUR.T2T.genome.chr.fasta
Bmor=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/final_assembly/gapfilling/sex_chr/reference_genomes/Bombyx_mori.genome.chr.fa
Cmed=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/final_assembly/gapfilling/sex_chr/reference_genomes/Cnaphalocrocis_medinalis.genome.chr.fa

nucmer -t 20 -p Ofur_Bmor $Bmor $Ofur
dnadiff -d Ofur_Bmor.delta -p Ofur_Bmor.delta.dnadiff

nucmer -t 20 -p Ofur_Cmed $Cmed $Ofur
dnadiff -d Ofur_Cmed.delta -p Ofur_Cmed.delta.dnadiff
