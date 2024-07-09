# !/bin/bash
fasta=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/Of_FP283.asm.bp.p_ctg.gfa.fa
ccs=/public/caiyuanshi/hifi/of_genome/1.HiFireads/Of_FP283.ccs.fastq.gz
tmp=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/purge_haplotigs/tmp
database=/public/caiyuanshi/bioinfo_software/busco_database

for i in "01.minimap2" "02.cov" "03.purge"
do
        if [ ! -d  "$i" ];then
                mkdir -p $i
        else
                echo "Directory exists."
        fi
done

##### activate conda environment #####
source /public/caiyuanshi/miniconda3/bin/activate purge_haplotigs

##### map hifi reads to genome #####
minimap2 -t 24 -ax map-hifi $fasta $ccs --secondary=no | samtools view -bS - | samtools sort -@ 4 -m 1G -O BAM -o 01.minimap2/aligned.bam -T $tmp/tmp.ali -

##### generate a coverage histogram #####
cd 02.cov
purge_haplotigs hist -b ../01.minimap2/aligned.bam -g $fasta

##### contigs converage stats #####
purge_haplotigs cov -i aligned.bam.gencov -l 5 -m 36 -h 110

##### purge #####
cd ../03.purge
purge_haplotigs purge -g $fasta -c ../02.cov/coverage_stats.csv -d -b ../01.minimap2/aligned.bam

##### evaluation #####
mkdir quast busco
for i in `ls ./*.fasta`
do

        python /public/caiyuanshi/miniconda3/envs/assembly/bin/quast ${i} -t 8 -o quast/${i##*/}
        busco -i ${i} -o ${i##*/} --out_path busco/ -m genome --augustus --offline -l ${database}/insecta_odb10 -c 24
done
