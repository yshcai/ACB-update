# !/bin/bash
rawdata_dir=/public/caiyuanshi/hifi/of_genome/0.rawdata/Axy-FP283/r64030_20220318_092639/
ccsdata_dir=/public/caiyuanshi/hifi/of_genome/1.HiFireads

source /public/caiyuanshi/miniconda3/bin/activate pbccs
nohup ccs ${rawdata_dir}/P05DY22557029-1_r64030_20220318_092639_3_H01.subreads.bam ${ccsdata_dir}/Of_FP283.ccs.fastq.gz --min-passes 3 \
--report-file ccs_report.txt --log-file ccs.log -j 0 &
