# !/bin/bash
fasta=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/Of_FP283.asm.bp.p_ctg.gfa.fa

##### activate conda environment #####
source /public/caiyuanshi/miniconda3/bin/activate seqtk

##### detect telomeric regions #####
seqtk telo -m CCTAA -s 1 $fasta > Of_FP283.asm.bp.p_ctg.gfa.fa.telo.bed 2> Of_FP283.asm.bp.p_ctg.gfa.fa.telo.count
