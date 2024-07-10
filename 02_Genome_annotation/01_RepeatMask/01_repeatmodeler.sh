# !/bin/bash
fasta=/share/home/nxy1hj2cys/hifi/t2t_of/3.Chromosome/Ostrinia_furnacalis_genome.fa
dir=/share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/01_RepeatMask
repeatmasker=/share/home/nxy1hj2cys/miniconda3/envs/repeatmask/share/RepeatMasker

for i in '01_repeatModeler-denovo-repeat.lib' '02_RepDfam.lib' '03_EDTA'
do
  if [ ! -d $dir/$i ];then
    mkdir -p $dir/$i
  fi
done

##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate repeatmask

##### RepeatModeler #####
cd $dir/01_repeatModeler-denovo-repeat.lib
BuildDatabase -name OFUR $fasta &>BuildDatabase_run.log
RepeatModeler -database OFUR -pa 28 -LTRStruct &>RepeatModeler_run.log
echo "repeatmodeler done!"

##### formatted name to be recognizable by EDTA #####
mkdir te_anno && cd te_anno
grep '>' $dir/01_repeatModeler-denovo-repeat.lib/OFUR-families.fa | sed 's/>//g' | less > OFUR-families.fa.header
python3 reclassify_RepLib_based_SO.py OFUR-families.fa.header OFUR-families.fa.id_rename_table

##### output corresponding fasta file #####
python3 rename_repeats_lib.py $dir/01_repeatModeler-denovo-repeat.lib/OFUR-families.fa OFUR-families.fa.id_rename_table OFUR-families.fa.final.fa
