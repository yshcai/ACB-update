# !/bin/bash
hic=/public/caiyuanshi/hifi/hic/ANNO_ANCGD180475_PM-ANCGD180475-17_2022-07-06_17-51-30_BHJCVYDSX3/Rawdata/FPH-2/

##### activate conda environment #####
source /public/caiyuanshi/miniconda3/bin/activate seqkit

##### simple statistics of FASTA/Q files #####
seqkit stats -a -j 2 $hic/FPH-2_R1.fq.gz $hic/FPH-2_R2.fq.gz > hicreads_stats.txt
