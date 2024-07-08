# !/bin/bash
ccs=/public/caiyuanshi/hifi/of_genome/1.HiFireads/Of_FP283.ccs.fastq.gz
asm=/public/caiyuanshi/hifi/t2t_of/2.Assembly
fasta=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta
database=/public/caiyuanshi/bioinfo_software/busco_database

mkdir -p $fasta/hifi_only_s0.25/busco
output=$fasta/hifi_only_s0.25
hifiasm -o ${asm}/Of_FP283.asm -t32 -s0.25 ${ccs} &> $output/run_hifisam.log

for i in `ls $asm/*.p_ctg.gfa`
do
        awk '/^S/{print ">"$2;print $3}' $i > $output/${i##*/}.fa
        python /public/caiyuanshi/miniconda3/envs/assembly/bin/quast $output/${i##*/}.fa -t 8 -o $output/quast/${i##*/}.fa
        busco -i $output/${i##*/}.fa -o ${i##*/}.fa --out_path $output/busco/ -m genome --augustus --offline -l ${database}/insecta_odb10 -c 32
done
