# !/bin/bash

ccs=/public/caiyuanshi/hifi/of_genome/1.HiFireads/Of_FP283.ccs.fasta
fasta=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/final_assembly/3dDNA_review/Of_FP283.asm.bp.p_ctg.final.w80.FINAL.rmdup.fasta

##### activate conda environment #####
source /public/caiyuanshi/miniconda3/bin/activate quartet

##### gap filling #####
quartet.py GapFiller -d $fasta -g $ccs -t 32
