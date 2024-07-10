# !/bin/bash

##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate EDTA2

cp /share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/01_RepeatMask/03_EDTA/Ostrinia_furnacalis_genome.fa.mod.EDTA.anno/Ostrinia_furnacalis_genome.fa.mod.EDTA.TEanno.split.gff3 ./

##### soft masking #####
grep -i -v -P "Satellite|rich|Simple_repeat|Low_complexity" Ostrinia_furnacalis_genome.fa.mod.EDTA.TEanno.split.gff3 | bedtools maskfasta \
        -fi Ostrinia_furnacalis_genome.fa -bed - -fo Ostrinia_furnacalis_genome.fa.soft.masked -soft

##### hard masking #####
grep -i -v -P "Satellite|rich|Simple_repeat|Low_complexity" Ostrinia_furnacalis_genome.fa.mod.EDTA.TEanno.split.gff3 | bedtools maskfasta \
        -fi Ostrinia_furnacalis_genome.fa -bed - -fo Ostrinia_furnacalis_genome.fa.hard.masked
