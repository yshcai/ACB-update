# !/bin/bash
GENOME=/share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/01_RepeatMask/04_generate_masked_fa/Ostrinia_furnacalis_genome.fa.hard.masked
RAWDATADIR=./00.ncbi_data
CLEANDATADIR=./01.cleandata
ALIGN=./02.align
GTF=./03.stringtie
MERGE=04.taco_merge
SE=./00.ncbi_data/single_end.list
PE=./00.ncbi_data/pair_end.list

for i in "$RAWDATADIR" "$CLEANDATADIR" "$ALIGN" "$GTF" "$MERGE"
do
        if [ ! -d $i ];then
                mkdir -p $i
        fi
done

##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate rnaseq

##### assembly gtf #####
for id in `cat $SE $PE`
do
        stringtie $ALIGN/${id}.bam -p 12 -o ${GTF}/${id}.gtf -l ${id}
done
