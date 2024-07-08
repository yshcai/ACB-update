# !/bin/bash
juicer=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/final_assembly/juicer

##### activate conda environment #####
source /public/caiyuanshi/miniconda3/bin/activate juicer

##### 3dDNA round 1 #####
if [ ! -d ${juicer%/*}/3dDNA ];then
        mkdir -p ${juicer%/*}/3dDNA
fi
references=$juicer/references
chr=${juicer%/*}/3dDNA
cd $chr
/public/caiyuanshi/bioinfo_software/3dDNA/3d-dna-master/run-asm-pipeline.sh --early-exit \
$references/${fasta##*/} $juicer/work/FPH2/aligned/merged_nodups.txt &>3dDNA_run.log
