# !/bin/bash

##### activate conda environment #####
source /public/caiyuanshi/miniconda3/bin/activate seqtk

##### detect telomeric regions #####
seqtk telo -m CCTAA -s 1 Of_FP283.asm.bp.p_ctg.gfa.fa > Of_FP283.asm.bp.p_ctg.gfa.fa.telo.bed 2> Of_FP283.asm.bp.p_ctg.gfa.fa.telo.count
