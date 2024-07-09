# !/bin/bash
phy=/share/home/nxy1hj2cys/hifi/t2t_of/5.Phylogeny/04.RAxML/all_single_copy_aln.phy

##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate evolution

##### raxml #####
raxmlHPC-PTHREADS-AVX2 -T 24 -f a -x 12345 -p 12345 -# 1000 -m PROTGAMMAILGF -k -O -o Daphnia_pulex,Daphnia_magna -n all_single_copy_aln.raxml.tree -s $phy
