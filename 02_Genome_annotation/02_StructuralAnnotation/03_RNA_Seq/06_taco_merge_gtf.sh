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

##### megre gtf #####
cd $MERGE
cat $SE $PE > gtf.list # after filter out samples with low mapping rate, run taco to merge these gtf
taco_run -p 28 gtf.list

##### fix gtf #####
gffread -T assembly.gtf -o assembly.format.gtf

##### convert gene structure gff3 to alignment gff3 required by maker #####
python3 taco_stringtie_gtf_2_maker_alignment_gff3.py assembly.format.gtf > taco_merge.alignment.gff3
