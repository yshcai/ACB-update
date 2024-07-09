# !/bin/bash
phy=/share/home/nxy1hj2cys/hifi/t2t_of/5.Phylogeny/04.RAxML/all_single_copy_aln.phy

##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate evolution

##### modeltest-ng #####
modeltest-ng -i $phy -d aa -o all_single_copy_aln.phy.modeltest -p 16 -r 12345
