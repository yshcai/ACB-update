# !/bin/bash
GENOME=/share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/01_RepeatMask/04_generate_masked_fa/Ostrinia_furnacalis_genome.fa.hard.masked
RAWDATADIR=./00.ncbi_data
CLEANDATADIR=./01.cleandata
ALIGN=./02.align
GTF=./03.stringtie
SE=./00.ncbi_data/single_end.list
PE=./00.ncbi_data/pair_end.list

# creat drectories
for i in "$RAWDATADIR" "$CLEANDATADIR" "$ALIGN" "$GTF"
do
        if [ ! -d $i ];then
                mkdir -p $i
        fi
done

##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate rnaseq

##### index bulid #####
if [ -e "$ALIGN/genome.1.ht2" ];then
        echo "HISAT2 index already exists."
else
        echo "HISAT2 index does not exist. Building index"
        hisat2-build -p 12 $GENOME $ALIGN/genome
        echo "Index build completed."
fi

##### single-end #####
for id in `cat $SE`
do
        hisat2 --dta -p 12 -x $ALIGN/genome -U ${CLEANDATADIR}/${id}.fastq.gz --summary-file $ALIGN/${id}_alignstat | samtools sort -@ 6 -o $ALIGN/${id}.bam -
done

##### paired-end #####
for id in `cat $PE`
do
        hisat2 --dta -p 12 -x $ALIGN/genome -1 ${CLEANDATADIR}/${id}_1.fastq.gz -2 ${CLEANDATADIR}/${id}_2.fastq.gz \
                --summary-file $ALIGN/${id}_alignstat | samtools sort -@ 6 -o $ALIGN/${id}.bam -
done
