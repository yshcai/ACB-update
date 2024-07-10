# !/bin/bash
denovo=/public/caiyuanshi/hifi/t2t_of/4.Annotation/01_RepeatMask/01_repeatModeler-denovo-repeat.lib/OFUR-families.fa
genome=/public/caiyuanshi/hifi/t2t_of/3.Chromosome/Ostrinia_furnacalis_genome.fa
DeepTE=/share/home/nxy1hj2cys/bioinfo/DeepTE
model=/share/home/nxy1hj2cys/bioinfo/DeepTE/model_dir/Metazoans_model
hmmscan=/share/home/nxy1hj2cys/bioinfo/hmmer/hmmer-3.3.2/bin/hmmscan

for i in 'te_anno/deepte/LINE_unknown' 'te_anno/deepte/ltr_unknown' 'te_anno/deepte/Repeat_unknown' 'te_anno/deepte/SINE_unknown'
do
  if [ ! -d $i ];then
    mkdir -p $i
  fi
done


##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate seqkit

cd te_anno
##### repeats without classification information #####
# LINE/Unknown
seqkit grep -r -i -p "LINE/Unknown" -w 60 OFUR-families.fa.final.fa -o OFUR-families.fa.rename.fa.LINE_Unknown.fa
# LTR/Unknown
seqkit grep -r -i -p "LTR/Unknown" -w 60 OFUR-families.fa.final.fa -o OFUR-families.fa.rename.fa.LTR_Unknown.fa
# repeat/Unknown
seqkit grep -r -i -p "repeat/Unknown" -w 60 OFUR-families.fa.final.fa -o OFUR-families.fa.rename.fa.Repeat_Unknown.fa
# SINE/Unknown
seqkit grep -r -i -p "SINE/Unknown" -w 60 OFUR-families.fa.final.fa -o OFUR-families.fa.rename.fa.SINE_Unknown.fa

##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate deepte

cd deepte
# classify LINE_unknown
$DeepTE/DeepTE_domain.py -d LINE_unknown -o LINE_unknown -i ../OFUR-families.fa.rename.fa.LINE_Unknown.fa -s $DeepTE/supfile_dir --hmmscan $hmmscan
$DeepTE/DeepTE.py -d LINE_unknown -o LINE_unknown -i ../OFUR-families.fa.rename.fa.LINE_Unknown.fa -sp M -m_dir $model \
-fam LINE -modify LINE_unknown/opt_te_domain_pattern.txt
python3 reclassify_based_DeepTE.py opt_DeepTE.txt LINE_Unknown.fa.id_rename_table

# classify LTR_unknown
$DeepTE/DeepTE_domain.py -d ltr_unknown -o ltr_unknown -i ../OFUR-families.fa.rename.fa.LTR_Unknown.fa -s $DeepTE/supfile_dir --hmmscan $hmmscan
$DeepTE/DeepTE.py -d ltr_unknown -o ltr_unknown -i ../OFUR-families.fa.rename.fa.LTR_Unknown.fa -sp M -m_dir $model \
-fam LTR -modify ltr_unknown/opt_te_domain_pattern.txt
python3 reclassify_based_DeepTE.py opt_DeepTE.txt LTR_Unknown.fa.id_rename_table

# classify Repeat_unknown
$DeepTE/DeepTE_domain.py -d Repeat_unknown -o Repeat_unknown -i ../OFUR-families.fa.rename.fa.Repeat_Unknown.fa -s $DeepTE/supfile_dir --hmmscan $hmmscan
$DeepTE/DeepTE.py -d Repeat_unknown -o Repeat_unknown -i ../OFUR-families.fa.rename.fa.Repeat_Unknown.fa -sp M -m_dir $model \
-modify Repeat_unknown/opt_te_domain_pattern.txt
python3 reclassify_based_DeepTE.py opt_DeepTE.txt Repeat_Unknown.fa.id_rename_table

# classify SINE_unknown
$DeepTE/DeepTE_domain.py -d SINE_unknown -o SINE_unknown -i ../OFUR-families.fa.rename.fa.SINE_Unknown.fa -s $DeepTE/supfile_dir --hmmscan $hmmscan
$DeepTE/DeepTE.py -d SINE_unknown -o SINE_unknown -i ../OFUR-families.fa.rename.fa.SINE_Unknown.fa -sp M -m_dir $model \
-fam SINE -modify SINE_unknown/opt_te_domain_pattern.txt
python3 reclassify_based_DeepTE.py opt_DeepTE.txt SINE_Unknown.fa.id_rename_table

##### get final repeatmodeler lib #####
cd ../
cat cat deepte/LINE_unknown/LINE_Unknown.fa.id_rename_table \
    deepte/ltr_unknown/LTR_Unknown.fa.id_rename_table \
    deepte/Repeat_unknown/Repeat_Unknown.fa.id_rename_table \
    deepte/SINE_unknown/SINE_Unknown.fa.id_rename_table > Unknown.id_rename_table
python3 rename_repeats_lib.py OFUR-families.fa.final.fa Unknown.id_rename_table OFUR-families.fa.final.fa2
source /share/home/nxy1hj2cys/miniconda3/bin/activate seqkit
seqkit seq -w 60 OFUR-families.fa.final.fa2 -o OFUR-families.fa.final.fa
rm OFUR-families.fa.final.fa2
