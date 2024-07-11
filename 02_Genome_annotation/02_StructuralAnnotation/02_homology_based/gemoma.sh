# !/bin/bash
Genome=/share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/02_StructuralAnnotation/02.homology-based/gemoma/Ostrinia_furnacalis_genome.fa.hard.masked.fasta
Reference=/share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/02_StructuralAnnotation/02.homology-based/gemoma/reference
Threads=64
Align=/share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/02_StructuralAnnotation/03.RNA_Seq-based/02.align
GeMoMa=/share/home/nxy1hj2cys/miniconda3/envs/gemoma/share/gemoma-1.9-0

##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate gemoma

##### run GeMoMa Pipeline #####
mkdir result
java -Xms64G -Xmx256G -jar $GeMoMa/GeMoMa-1.9.jar CLI GeMoMaPipeline threads=$Threads outdir=result/ GeMoMa.Score=ReAlign AnnotationFinalizer.r=NO p=true o=true tblastn=false t=$Genome \
s=own i=Bmor a=$Reference/Bombyx_mori/Bombyx_mori.gff g=$Reference/Bombyx_mori/Bombyx_mori.fna \
s=own i=Dmel a=$Reference/Drosophila_melanogaster/Drosophila_melanogaster.gff g=$Reference/Drosophila_melanogaster/Drosophila_melanogaster.fna \
s=own i=Gmel a=$Reference/Galleria_mellonella/Galleria_mellonella.gff g=$Reference/Galleria_mellonella/Galleria_mellonella.fna \
s=own i=Onub a=$Reference/Ostrinia_nubilalis/Ostrinia_nubilalis.gff g=$Reference/Ostrinia_nubilalis/Ostrinia_nubilalis.fna \
s=own i=Pxyl a=$Reference/Plutella_xylostella/Plutella_xylostella.gff g=$Reference/Plutella_xylostella/Plutella_xylostella.fna \
r=MAPPED \
ERE.m=$Align/DRR018822.bam ERE.m=$Align/DRR018823.bam ...

##### convert gene structure gff3 to alignment gff3 required by maker #####
cd result/
python3 gemoma_gff3_2_maker_alignment_gff3.py final_annotation.gff > gemoma.protein_alignment.gff3
