# !/bin/bash
mafft=/share/home/nxy1hj2cys/hifi/t2t_of/5.Phylogeny/02.Mafft

##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate evolution

##### trim multiple sequence alignment results #####
for i in `ls $mafft/*.aln`
do
        file=$(basename $i)
        file=${file%.*}
        trimal -in $i -out ${file}.trimal -automated1
done

##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate seqkit

##### sort and convert format #####
for i in `ls $mafft/*.aln`
do
        file=$(basename $i)
        file=${file%.*}
        seqkit sort ${file}.trimal | seqkit seq -w 0 - -o "${file}.trimal.sort"
done

##### concatenated all alignment results to create one super alignment #####
paste -d " " *.trimal.sort > all_single_copy_aln.fa
sed -i "s/\ //g" all_single_copy_aln.fa
