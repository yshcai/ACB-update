# !/bin/bash
# How to run the Juicer on the target genome assembly?

fasta=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/Of_FP283.asm.bp.p_ctg.gfa.fa
juicer=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/juicer
raw=/public/caiyuanshi/hifi/hic/ANNO_ANCGD180475_PM-ANCGD180475-17_2022-07-06_17-51-30_BHJCVYDSX3/Rawdata/FPH-2

if [ ! -d $juicer ];then
        mkdir -p $juicer
fi

# 0.hic reads
mkdir -p $juicer/work/FPH2/fastq
fastq=$juicer/work/FPH2/fastq
cd $fastq
ln -s $raw/*.gz ./
rename .fq.gz .fastq.gz *.fq.gz

# 1.genome index
mkdir -p $juicer/references
references=$juicer/references
cd $references
cp $fasta ./
bwa index -p ${fasta##*/} ${fasta##*/} &>bwa_run.log

# 2.restriction enzyme map
mkdir -p $juicer/restriction_sites
restriction_sites=$juicer/restriction_sites
cd $restriction_sites
python /public/caiyuanshi/bioinfo_software/juicer/juicer-1.6/misc/generate_site_positions.py DpnII Of_FP283 $references/${fasta##*/} &> restriction_site.log
awk 'BEGIN{OFS="\t"}{print $1, $NF}' Of_FP283_DpnII.txt > Of_FP283.chrom.sizes # generate chromosomes size file

# 3.scripts
cd $juicer
ln -s /public/caiyuanshi/bioinfo_software/juicer/juicer-1.6/CPU scripts

# 4.run juicer.sh
/public/caiyuanshi/bioinfo_software/juicer/juicer-1.6/CPU/juicer.sh \
-z $references/${fasta##*/} \
-p $restriction_sites/Of_FP283.chrom.sizes \
-s DpnII \
-y $restriction_sites/Of_FP283_DpnII.txt \
-d ${fastq%/*} \
-D $juicer \
-t 32 &> juicer_run.log
