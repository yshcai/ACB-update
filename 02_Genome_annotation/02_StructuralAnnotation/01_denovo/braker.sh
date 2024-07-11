# !/bin/bash
GENOME=/share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/01_RepeatMask/04_generate_masked_fa/Ostrinia_furnacalis_genome.fa.soft.masked
PROTEIN=/share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/02_StructuralAnnotation/01.braker/Arthropoda.fa
RESULT=/share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/02_StructuralAnnotation/01.braker/out
BAM=/share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/02_StructuralAnnotation/01.braker/align

if [ ! -d $RESULT ]; then
        mkdir -p $RESULT
fi

##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate braker3

##### run with RNA-Seq and protein data #####
braker.pl --species=Ofur \
        --genome=$GENOME \
        --prot_seq=$PROTEIN \
        --rnaseq_sets_ids=DRR018822,DRR018823, ... \
        --rnaseq_sets_dirs=$BAM \
        --threads 48 --gff3 --workingdir=out \
        --GENEMARK_PATH=/share/home/nxy1hj2cys/bioinfo/GeneMark/GeneMark-ETP/bin/ \
        --PROTHINT_PATH=/share/home/nxy1hj2cys/bioinfo/GeneMark/GeneMark-ETP/bin/gmes/ProtHint/bin/
