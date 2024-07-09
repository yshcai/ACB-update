# !/bin/bash
fa=/share/home/nxy1hj2cys/hifi/t2t_of/5.Phylogeny/01.OrthoFinder2/02.output/Results_Jun04/Single_Copy_Orthologue_Sequences

##### activate conda environment #####
source /public/caiyuanshi/miniconda3/bin/activate evolution

##### perform multiple alignment #####
for i in `ls $fa/*.fa`;
do
        mafft --thread 16 --auto $i > $(basename $i).mafft.aln
done
