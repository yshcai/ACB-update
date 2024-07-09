# !/bin/bash
##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate evolution

##### mcmctree #####
mcmctree mcmctree.ctl

##### generate the Hessian matrix with LG+Gamma for the protein data #####
# Delete the "out.BV" and "rst" files that were generated
codeml tmp0001.ctl
