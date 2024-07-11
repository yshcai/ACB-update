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

##### single-end #####
for id in `cat $SE`
do
        fastp -i $RAWDATADIR/${id}.fastq.gz -o ${CLEANDATADIR}/${id}.fastq.gz \
                --thread 32 --json ${CLEANDATADIR}/${id}.json --html ${CLEANDATADIR}/${id}.html > ${CLEANDATADIR}/${id}_fastp.log 2>&1
done

##### paired-end #####
for id in `cat $PE`
do
        fastp -i $RAWDATADIR/${id}_1.fastq.gz -I $RAWDATADIR/${id}_2.fastq.gz -o ${CLEANDATADIR}/${id}_1.fastq.gz -O ${CLEANDATADIR}/${id}_2.fastq.gz \
                --detect_adapter_for_pe --thread 32 --json ${CLEANDATADIR}/${id}.json --html ${CLEANDATADIR}/${id}.html 1> ${CLEANDATADIR}/${id}_fastp.log 2>&1
done
