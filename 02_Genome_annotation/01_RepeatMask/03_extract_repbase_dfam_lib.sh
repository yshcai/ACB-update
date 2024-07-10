# !/bin/bash
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

##### repbase build #####
cd $dir/02_RepDfam.lib
$repeatmasker/famdb.py -i $repeatmasker/Libraries/RepeatMaskerLib.h5 families --format fasta_name -ad 'Insecta' --include-class-in-name | less > Insecta_RepBase.fasta
echo "repbase build done!"

##### formatted name to be recognizable by EDTA #####
grep '>' Insecta_RepBase.fasta | sed 's/>//g' | less > Insecta_RepBase.header
python3 reclassify_RepLib_based_SO.py Insecta_RepBase.header Insecta_RepBase.id_rename_table

##### output corresponding fasta file #####
python3 rename_repeats_lib.py Insecta_RepBase.header Insecta_RepBase.id_rename_table Insecta_RepBase.rename.fa
