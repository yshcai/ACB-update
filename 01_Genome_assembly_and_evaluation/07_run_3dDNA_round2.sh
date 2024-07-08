# !/bin/bash
juicer=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/final_assembly/juicer

##### activate conda environment #####
source /public/caiyuanshi/miniconda3/bin/activate juicer

##### 3dDNA round 2 #####
if [ ! -d ${juicer%/*}/3dDNA_review ];then
        mkdir -p ${juicer%/*}/3dDNA_review
fi
references=$juicer/references
cd ${juicer%/*}/3dDNA_review
run-asm-pipeline-post-review.sh --sort-output --build-gapped-map -r Of_FP283.asm.bp.p_ctg.final.w80.0.review2.assembly \
$references/${fasta##*/} $juicer/work/FPH2/aligned/merged_nodups.txt &>3dDNA_review.log
