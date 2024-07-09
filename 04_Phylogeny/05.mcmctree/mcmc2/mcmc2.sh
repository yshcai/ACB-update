# !/bin/bash
##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate evolution

##### run MCMCTree with the approximate method #####
cp -r mcmc1/rst2 mcmc2/in.BV
mcmctree mcmctree.ctl
