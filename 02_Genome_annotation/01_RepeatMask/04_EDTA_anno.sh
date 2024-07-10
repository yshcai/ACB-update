# !/bin/bash

##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate EDTA2

##### EDTA2 #####
EDTA.pl --genome /share/home/nxy1hj2cys/hifi/t2t_of/3.Chromosome/Ostrinia_furnacalis_genome.fa --species others --step all --overwrite 0 \
        --cds /share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/01_RepeatMask/03_EDTA/reference_assembly_cds_smiplifyID.fa \
        --curatedlib /share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/01_RepeatMask/02_RepDfam.lib/Insecta_RepBase.rename.fa \
        --rmlib /share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/01_RepeatMask/01_repeatModeler-denovo-repeat.lib/te_anno/OFUR-families.fa.final.fa \
        --sensitive 1 --anno 1 --threads 32
